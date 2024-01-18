# frozen_string_literal: true

module Products
  class ListPresenter < ApplicationPresenter
    private

    def initialize(products)
      @products = products

      super()
    end

    def build_view
      @products.map do |product|
        {
          code: product.code,
          name: product.name,
          price: product.price.format
        }
      end.to_yaml
    end
  end
end
