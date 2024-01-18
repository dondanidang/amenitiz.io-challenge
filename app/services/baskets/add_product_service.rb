# frozen_string_literal: true

module Baskets
  class AddProductService < ApplicationService
    private

    # It initializes a new AddProductService.
    #
    # product - The Product to be scanned.
    #
    def initialize(product)
      @product = product

      super()
    end

    # It scans a product and adds it to the basket.
    #
    # Returns BasketProduct.
    def call
      BasketProduct.create!(basket: basket, product: @product)
    end

    def basket
      @basket ||= Basket.find_or_create_by!(status: Basket::STATUSES[:initiated])
    end
  end
end
