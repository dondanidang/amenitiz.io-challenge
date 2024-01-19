# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { Faker::Alphanumeric.alpha(number: 5).upcase }
    name { Faker::Commerce.product_name }
    price_cents { Faker::Commerce.price(range: 0.01..100.0) * 100 }
  end
end
