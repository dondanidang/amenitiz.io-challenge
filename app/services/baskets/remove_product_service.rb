# frozen_string_literal: true

module Baskets
  class RemoveProductService < ApplicationService
    private

    # It initializes a new RemoveProductService.
    #
    # product - The Product to be remove.
    #
    def initialize(product)
      @product = product

      super()
    end

    # It remove product from basket if exisit
    #
    # Returns BasketProduct.
    def call
      basket_product.update!(removed_at: DateTime.current)

      basket_product
    end

    def basket_product
      @basket_product ||= BasketProduct.not_removed.find_by!(basket: basket, product: @product)
    rescue ActiveRecord::RecordNotFound
      raise Errors::ProductNotInBasket
    end

    def basket
      @basket ||= Basket.find_by!(status: Basket::STATUSES[:initiated])
    rescue ActiveRecord::RecordNotFound
      raise Errors::NoInitiatedBasketFound
    end
  end
end
