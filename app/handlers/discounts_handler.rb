class DiscountsHandler
  class << self
    def list
      discounts = Discount
        .includes(:product_discounts)
        .where(product_discounts: { disabled_at: nil })

      puts Discounts::ListPresenter.build_view(discounts)
    end
  end
end
