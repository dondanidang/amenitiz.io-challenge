# frozen_string_literal: true

class Product < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :price_cents, presence: true

  def price
    Money.new(price_cents, price_currency)
  end

  def price=(value)
    self.price_cents = value.cents
    self.currency = value.currency.iso_code
  end
end
