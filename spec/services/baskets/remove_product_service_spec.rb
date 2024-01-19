# frozen_string_literal: true

require 'spec_helper'

describe Baskets::RemoveProductService do
  describe '.call' do
    subject(:remmove_product_from_basket) do
      described_class.call(product)
    end

    let(:product) { create(:product) }

    context 'when initiated basket does not exist' do
      it 'raiss Baskets::Errors::NoInitiatedBasketFound' do
        expect { remmove_product_from_basket }.to raise_error(Baskets::Errors::NoInitiatedBasketFound)
      end
    end

    context 'when basket is empty' do
      before do
        create(:basket, status: Basket::STATUSES[:initiated])
      end

      it 'raiss Baskets::Errors::BasketIsEmpty' do
        expect { remmove_product_from_basket }.to raise_error(Baskets::Errors::BasketIsEmpty)
      end
    end

    context 'when basket does not contain product' do
      before do
        basket = create(:basket, status: Basket::STATUSES[:initiated])
        create(:basket_product, basket: basket)
      end

      it 'raiss Baskets::Errors::ProductNotInBasket' do
        expect { remmove_product_from_basket }.to raise_error(Baskets::Errors::ProductNotInBasket)
      end
    end

    context 'when basket contains the product' do
      before do
        basket = create(:basket, status: Basket::STATUSES[:initiated])
        create(:basket_product, basket: basket, product: product)
      end

      it 'removes product from basket' do
        expect(remmove_product_from_basket).to have_attributes(
          product_id: product.id,
          removed_at: be_present
        )
      end
    end
  end
end
