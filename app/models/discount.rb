# frozen_string_literal: true

class Discount < ActiveRecord::Base
  validates :code, presence: true
  validates :description, presence: true

  has_many :product_discounts, -> { active }, inverse_of: :discount
  has_many :products, through: :product_discounts

  belongs_to :rulable, polymorphic: true
end
