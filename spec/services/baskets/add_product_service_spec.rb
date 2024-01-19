# frozen_string_literal: true

require 'spec_helper'

describe Baskets::AddProductService do
  describe '.call' do
    subject(:add_producto_basket) do
      described_class.call(product)
    end

    let(:product) { create(:product) }

    it 'adds product to basket' do
      aggregate_failures do
        expect { add_producto_basket }
          .to change { Basket.count }.by(1)
          .and change { BasketProduct.count }.by(1)

        expect(BasketProduct.last).to have_attributes(
          product_id: product.id,
          removed_at: nil
        )
      end
    end

    context 'when initiated basket already exist' do
      let!(:basket) { create(:basket, status: Basket::STATUSES[:initiated]) }

      it 'adds product to basket' do
        aggregate_failures do
          expect { add_producto_basket }
            .to change { BasketProduct.count }.by(1)
            .and not_change { Basket.count }

          expect(BasketProduct.last).to have_attributes(
            product_id: product.id,
            basket_id: basket.id,
            removed_at: nil
          )
        end
      end
    end
  end
end
