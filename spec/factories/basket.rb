# frozen_string_literal: true

FactoryBot.define do
  factory :basket do
    status { Basket::STATUSES.keys.sample }
    total_cents { 0 }
    total_paid_cents { 0 }
  end
end
