class SeedDataLoader
  class << self
    def load
      products = [
        {code: 'GR1', name: 'Green tea', price_cents: 311},
        {code: 'SR1', name: 'Strawberries', price_cents: 500},
        {code: 'CF1', name: 'Coffee', price_cents: 1123}
      ].map {Product.new(**_1)}

      Product.import!(products, on_duplicate_key_ignore: true)

      product_by_code = Product.all.index_by(&:code)

      discounts = [
        {
          code: 'GR12x1',
          description: 'Buy One Get One Free on Green Tea',
          product_code: 'GR1',
          discount_value: 50,
          discount_unit: 'percentage',
          quantity: 2,
          operator: 'modulus'
        },
        {
          code: '3+SR1',
          description: 'Buy 3 or more Strawberries and the price drops to €4.50',
          product_code: 'SR1',
          discount_value: 50,
          discount_unit: 'cents',
          quantity: 3,
          operator: 'gte'
        },
        {
          code: '3+CF1',
          description: 'Buy 3 or more Coffee and the price drops 2/3 of the original price',
          product_code: 'CF1',
          discount_value: '1/3',
          discount_unit: 'divisor',
          quantity: 3,
          operator: 'gte'
        }
      ]

      discounts.each do |discount_data|
        discount_rule = QuantityBasedDiscount.find_or_create_by!(
          discount_value: discount_data[:discount_value],
          discount_unit: discount_data[:discount_unit],
          quantity: discount_data[:quantity],
          operator: discount_data[:operator]
        )

        discount = Discount.find_or_initialize_by(code: discount_data[:code])
        discount.assign_attributes(
          description: discount_data[:description],
          rulable: discount_rule
        )
        discount.save!

        product_discount = ProductDiscount.find_or_create_by!(
          product: product_by_code[discount_data[:product_code]],
          discount: discount
        )
      end
    end
  end
end
