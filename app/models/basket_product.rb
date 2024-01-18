# frozen_string_literal: true

class BasketProduct < ActiveRecord::Base
  belongs_to :basket, inverse_of: :basket_products
  belongs_to :product, inverse_of: :basket_products

  scope :not_removed, -> { where(removed_at: nil) }
end
