module CliErrors
  class ProductNotInBasketError < BaseError
    def initialize(product_code)
      super("Product with code #{product_code} is not in the basket")
    end
  end
end
