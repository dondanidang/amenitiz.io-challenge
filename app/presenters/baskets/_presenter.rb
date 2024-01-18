# frozen_string_literal: true

module Baskets
  class PartialPresenter < ApplicationPresenter
    protected
    def build_view_raw
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
      }
    end

    private

    def initialize(basket)
      @basket = basket

      super()
    end

    def build_view
      build_view_raw.to_yaml
    end
  end
end
