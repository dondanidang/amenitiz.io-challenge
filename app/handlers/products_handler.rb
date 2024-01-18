class ProductsHandler
  class << self
    def list
      puts Products::ListPresenter.build_view(Product.all)
    end
  end
end
