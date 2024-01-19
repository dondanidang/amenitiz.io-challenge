# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    code { Faker::Alphanumeric.alpha(number: 5).upcase }
    description { Faker::Lorem.sentence }

    after(:build) do |discount|
      discount.rulable ||= create(:quantity_based_discount)
    end
  end
end
