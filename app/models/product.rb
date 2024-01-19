# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price_cents, presence: true

  has_many :basket_products, inverse_of: :product
  has_many :product_discounts, -> { active } , inverse_of: :product
  has_many :discounts, through: :product_discounts

  def price
    Money.new(price_cents, price_currency)
  end

  def price=(value)
    self.price_cents = value.cents
    self.currency = value.currency.iso_code
  end
end
