module Baskets::Errors
  class Base < StandardError; end

  class NoInitiatedBasketFound < Base; end
  class ProductNotInBasket < Base; end
end
