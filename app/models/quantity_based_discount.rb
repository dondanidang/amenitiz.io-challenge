# frozen_string_literal: true

class QuantityBasedDiscount < ActiveRecord::Base
  has_many :discounts, as: :rulable
end
