module Errors
  class Base < StandardError; end

  class BasketNotFound < Base; end
  class ProductNotFound < Base; end
  class ProductAlreadyInBasket < Base; end
  class ProductNotInBasket < Base; end
end
