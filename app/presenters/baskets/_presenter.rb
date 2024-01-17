# frozen_string_literal: true

module Baskets
  class BasePresenter < ApplicationPresenter
    private

    def initialize(basket)
      @basket = basket

      super()
    end

    def build_view
      products_hash = @basket.products.map do |product|
        {
          code: product.code,
          name: product.name,
          price: product.price.format
        }
      end

      {
        id: @basket.id,
        products: products_hash
      }.to_yaml
    end
  end
end
