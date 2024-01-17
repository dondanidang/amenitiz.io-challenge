class ProductsHandler
  class << self
    def list
      products_view =  Product
        .all
        .map do |product|
          {
            code: product.code,
            name: product.name,
            price: product.price.format
          }
        end.to_yaml

      puts products_view
    end
  end
end
