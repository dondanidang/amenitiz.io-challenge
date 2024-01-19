# frozen_string_literal: true

module Baskets
  class ComputeDiscountService < ApplicationService
    private

    # It initializes a new ComputeDiscountService.
    #
    # basket - The Basket to be computed.
    #
    def initialize(basket)
      @basket = basket

      super()
    end

    # It computes the total discount applicable to the basket.
    #
    # Returns total_discount.
    def call
      discounts.map do |discount|
        calculate_discount(discount)
      end.sum
    end

    def calculate_discount(discount)
      affected_product_ids = discount.product_discounts.pluck(:product_id)
      affected_products = products.select { affected_product_ids.include?(_1.id) }

      discount_rule = discount.rulable

      case discount_rule.operator
      when 'modulus'
        handle_modulus(discount_rule, affected_products)
      when 'gte'
        handle_gte(discount_rule, affected_products)
      else
        raise NotDiscountCalculationImplementedError
      end
    end

    def handle_modulus(discount_rule, affected_products)
      return Money.zero if affected_products.size < discount_rule.quantity

      total_product_with_discount = (affected_products.size / discount_rule.quantity) * discount_rule.quantity

      discount_per_product = case discount_rule.discount_unit
      when 'percentage'
        (discount_rule.discount_value.to_i / 100.0) * affected_products.first.price
      when 'cents'
        Money.new(discount_rule.discount_value.to_i)
      when 'divisor'
        numerator, denominator = discount_rule.discount_value.split('/').map(&:to_f)

        affected_products.first.price * (numerator / denominator)
      else
        raise NotDiscountRuleOperatorImplementedError
      end

      total_product_with_discount * discount_per_product
    end

    def handle_gte(discount_rule, affected_products)
      total_product_with_discount = affected_products.size

      return Money.zero if total_product_with_discount < discount_rule.quantity

      discount_per_product = case discount_rule.discount_unit
      when 'percentage'
        (discount_rule.discount_value.to_i / 100.0) * affected_products.first.price
      when 'cents'
        Money.new(discount_rule.discount_value.to_i)
      when 'divisor'
        numerator, denominator = discount_rule.discount_value.split('/').map(&:to_f)

        affected_products.first.price * (numerator / denominator) * 1.0
      else
        raise NotDiscountRuleOperatorImplementedError
      end

      total_product_with_discount * discount_per_product
    end

    def discounts
      @discounts ||= Discount
        .includes(:product_discounts)
        .where(product_discounts: { product_id: product_ids, disabled_at: nil })
    end

    def products
      @products ||= @basket.products
    end

    def product_ids
      @product_ids ||= products.pluck(:id)
    end
  end
end
