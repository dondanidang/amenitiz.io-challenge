# frozen_string_literal: true

require 'spec_helper'

describe Baskets::ComputeDiscountService do
  describe '.call' do
    subject(:compute_total_of_the_basket) do
      described_class.call(basket)
    end

    let(:basket) { create(:basket, status: Basket::STATUSES[:initiated]) }

    before do
      gr_product = create(:product, price_cents: 311, code: 'GR1')
      gr_discount_rule = create(
        :quantity_based_discount,
        discount_value: '50',
        discount_unit: 'percentage',
        quantity: 2,
        operator: 'modulus'
      )
      gr_discount = create(:discount, rulable: gr_discount_rule)
      create(:product_discount, product: gr_product, discount: gr_discount)


      sr_product = create(:product, price_cents: 500, code: 'SR1')
      sr_discount_rule = create(
        :quantity_based_discount,
        discount_value: '50',
        discount_unit: 'cents',
        quantity: 3,
        operator: 'gte'
      )
      sr_discount = create(:discount, rulable: sr_discount_rule)
      create(:product_discount, product: sr_product, discount: sr_discount)

      cf_product = create(:product, price_cents: 1123, code: 'CF1')
      cf_discount_rule = create(
        :quantity_based_discount,
        discount_value: '1/3',
        discount_unit: 'divisor',
        quantity: 3,
        operator: 'gte'
      )
      cf_discount = create(:discount, rulable: cf_discount_rule)
      create(:product_discount, product: cf_product, discount: cf_discount)
    end

    context 'when discount on GR1 is applied' do
      before do
        create(:basket_product, basket: basket, product: Product.find_by(code: 'GR1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'GR1'))
      end

      it 'returns total with discount applied' do
        expect(compute_total_of_the_basket).to eq(Money.from_amount(3.11, 'EUR'))
      end
    end

    context 'when discount on SR1 is applied' do
      before do
        create(:basket_product, basket: basket, product: Product.find_by(code: 'SR1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'SR1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'SR1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'GR1'))
      end

      it 'returns total with discount applied' do
        expect(compute_total_of_the_basket).to eq(Money.from_amount(1.5, 'EUR'))
      end
    end

    context 'when discount on CF1 is applied' do
      before do
        create(:basket_product, basket: basket, product: Product.find_by(code: 'CF1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'CF1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'CF1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'SR1'))
        create(:basket_product, basket: basket, product: Product.find_by(code: 'GR1'))
      end

      it 'returns total with discount applied' do
        expect(compute_total_of_the_basket.round).to eq(Money.from_amount(11.23, 'EUR'))
      end
    end
  end
end
