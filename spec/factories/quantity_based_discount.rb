# frozen_string_literal: true

FactoryBot.define do
  factory :quantity_based_discount do
    discount_value { Faker::Number.between(from: 1, to: 100) }
    discount_unit { 'cents' }
    quantity { Faker::Number.between(from: 1, to: 10) }
    operator { ['gte', 'modulus'].sample }
  end
end
