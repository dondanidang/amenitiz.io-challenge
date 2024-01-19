# frozen_string_literal: true

require 'spec_helper'

describe Baskets::AddProductService do
  describe '.call' do
    subject(:add_producto_basket) do
      described_class.call(product)
    end

    let(:product) { create(:product) }

    it 'adds product to basket' do
      expect { add_producto_basket }
        .to change { Basket.count }.by(1)
        .and change { BasketProduct.count }.by(1)
    end

    context 'when initiated basket already exist' do
      before { create(:basket, status: Basket::STATUSES[:initiated]) }

      it 'adds product to basket' do
        expect { add_producto_basket }
          .to change { BasketProduct.count }.by(1)
          .and not_change { Basket.count }
      end
    end
  end
end
