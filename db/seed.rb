class SeedDataLoader
  class << self
    def load
      products = [
        {code: 'GR1', name: 'Green tea', price_cents: 311},
        {code: 'SR1', name: 'Strawberries', price_cents: 500},
        {code: 'CF1', name: 'Coffee', price_cents: 1123}
      ].map {Product.new(**_1)}

      Product.import!(products, on_duplicate_key_ignore: true)
    end
  end
end
