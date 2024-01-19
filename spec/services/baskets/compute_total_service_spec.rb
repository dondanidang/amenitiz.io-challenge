# frozen_string_literal: true

require 'spec_helper'

describe Baskets::ComputeTotalService do
  describe '.call' do
    subject(:compute_total_of_the_basket) do
      described_class.call(basket)
    end

    let(:basket) { create(:basket, status: basket::STATUSES[:initiated]) }

    context 'when basket is empty' do
      it 'returns zero' do
        byebug
        expect(compute_total_of_the_basket).to eq(Money.zero('EUR'))
      end
    end

    context 'when basket contains products' do
      before do
        product = create(:product, price_cents: 311)
        create(:basket_product, basket: basket, product: product)
      end

      it 'returns 3.11€' do
        expect(compute_total_of_the_basket).to eq(Money.from_amount(3.11, 'EUR'))
      end
    end
  end
end
