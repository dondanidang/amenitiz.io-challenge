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
      Money.new(@basket.products.sum(:price_cents))
    end
  end
end
