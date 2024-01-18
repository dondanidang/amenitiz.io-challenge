class BasketHandler
  class << self
    def add(product_code)
      product = Product.find_by!(code: product_code)
      basket_product = Baskets::AddProductService.call(product)

      puts "product #{product_code} successfully added to basket"
      puts Baskets::AddPresenter.build_view(basket_product.basket)
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::ProductNotFoundError.new(product_code).message
    end

    def compute_total
      basket = Basket.includes(:products).find_by!(status: Basket::STATUSES[:initiated])

      Baskets::ComputeTotalService.call(basket)

      puts Baskets::ComputeTotalPresenter.build_view(basket)
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::BasketIsEmptyError.new.message
    end

    def cancel
      basket = Basket.find_by!(status: Basket::STATUSES[:initiated])
      basket.update!(status: Basket::STATUSES[:canceled])

      puts "Basket has been successfully canceled"
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::BasketIsEmptyError.new.message
    end

    def complete
      basket = Basket.find_by!(status: Basket::STATUSES[:initiated])
      basket.update!(status: Basket::STATUSES[:completed])

      puts "Basket has been successfully completed"
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::BasketIsEmptyError.new.message
    end

    def show
      basket = Basket.includes(:products).find_by!(status: Basket::STATUSES[:initiated])

      return puts CliErrors::BasketIsEmptyError.new.message if basket.products.empty?

      puts Baskets::ShowPresenter.build_view(basket)
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::BasketIsEmptyError.new.message
    end

    def remove(product_code)
      product = Product.find_by!(code: product_code)
      basket_product = Baskets::RemoveProductService.call(product)

      puts "product #{product_code} successfully removed from the basket"
      puts Baskets::RemovePresenter.build_view(basket_product.basket)
    rescue ActiveRecord::RecordNotFound
      puts CliErrors::ProductNotFoundError.new(product_code).message
    rescue Baskets::Errors::BasketIsEmpty
      puts CliErrors::BasketIsEmptyError.new.message
    rescue Baskets::Errors::ProductNotInBasket
      puts CliErrors::ProductNotInBasketError.new(product_code).message
    rescue Baskets::Errors::NoInitiatedBasketFound
      puts CliErrors::BasketIsEmptyError.new.message
    rescue
    end
  end
end
