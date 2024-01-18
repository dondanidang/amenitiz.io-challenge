# frozen_string_literal: true

module Baskets
  class ComputeTotalService < ApplicationService
    private

    # It initializes a new ComputeTotalService.
    #
    # basket - The Basket to be computed.
    #
    def initialize(basket)
      @basket = basket

      super()
    end

    # It computes the total of the basket.
    #
    # Returns Basket.
    def call
      @basket.total = total
      @basket.total_paid = total_with_discount
      @basket.save!

      @basket
    end

    def total
      Money.new(@basket.products.sum(:price_cents))
    end

    def total_with_discount
      products.sum do |product|
        product_price = product.price

        discounts = discounts_by_product_id[product.id]

        unless discounts.blank?
          product_price = discounts.map { _1.apply(product_price) }
        end

        product_price
      end
    end

    def discounts
      @discounts ||= @basket.discounts
    end

    def discounts_by_product_id
      @discounts_by_product_id ||= discounts.group_by(&:product_id)
    end

    def products
      @products ||= @basket.products
    end

    def product_codes
      @product_codes ||= products.pluck(:code)
    end
  end
end
