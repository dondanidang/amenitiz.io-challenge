# frozen_string_literal: true

FactoryBot.define do
  factory :basket_product do
    basket
    product
  end
end
