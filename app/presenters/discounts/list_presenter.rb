# frozen_string_literal: true

module Discounts
  class ListPresenter < ApplicationPresenter
    private

    def initialize(discounts)
      @discounts = discounts

      super()
    end

    def build_view
      @discounts.map do |discount|
        {
          code: discount.code,
          description: discount.description
        }
      end.to_yaml
    end
  end
end
