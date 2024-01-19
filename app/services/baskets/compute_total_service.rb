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
      @basket.total_paid = total - total_discount
      @basket.save!

      @basket
    end

    def total_discount
      @total_discount ||= ComputeDiscountService.call(@basket)
    end

    def total
      @total ||= Money.new(@basket.products.sum(:price_cents))
    end

    def products
      @products ||= @basket.products
    end
  end
end
