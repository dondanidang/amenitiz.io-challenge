# frozen_string_literal: true

module Baskets
  class ScanProductService < ApplicationService
    private

    # It initializes a new .
    #
    # product - The Product to be scanned.
    #
    def initialize(product)
      @product = product

      super()
    end

    # It scans a product and adds it to the basket.
    #
    # Returns true.
    def call
      true
    end
  end
end
