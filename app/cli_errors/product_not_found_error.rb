module CliErrors
  class ProductNotFoundError < BaseError
    def initialize(product_code)
      super("Product with code #{product_code} does not exist")
    end
  end
end
