# frozen_string_literal: true

FactoryBot.define do
  factory :product_discount do
    discount
    product
  end
end
