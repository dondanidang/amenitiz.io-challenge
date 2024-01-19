# frozen_string_literal: true

class ProductDiscount < ActiveRecord::Base
  belongs_to :discount, inverse_of: :product_discounts
  belongs_to :product, inverse_of: :product_discounts

  scope :active, -> { where(disabled_at: nil) }
end
