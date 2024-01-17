class BasketHandler
  class << self
    def add(product_code)
      product = Product.find_by!(code: product_code)
      basket_product = Baskets::AddProductService.call(product)

      puts Baskets::AddPresenter.build_view(basket_product.basket)
    rescue ActiveRecord::RecordNotFound
      puts "Product with code #{product_code} does not exist"
    end

    def compute_total
      puts "Computing total"
    end

    def cancel
      basket = Basket.find_by!(status: Basket::STATUSES[:initiated])
      basket.update!(status: Basket::STATUSES[:cancelled])

      puts Baskets::CancelPresenter.build_view(basket)
    end

    def show
      basket = Basket.find_by!(status: Basket::STATUSES[:initiated])

      puts Baskets::ShowPresenter.build_view(basket)
    rescue ActiveRecord::RecordNotFound
      puts "Your basket is currently empty!"
    end

    def remove(product_code)
      product = Product.find_by!(code: product_code)
      basket_product = Baskets::RemoveProductService.call(product)

      puts Baskets::AddPresenter.build_view(basket_product.basket)
    rescue ActiveRecord::RecordNotFound
      puts "Product with code #{product_code} does not exist"
    rescue Baskets::Errors::ProductNotFound
      puts "Product with code #{product_code} is not in the basket"
    rescue Baskets::Errors::NoBasketInitiated
      puts "Your basket is currenly empty!"
    rescue
    end
  end
end
