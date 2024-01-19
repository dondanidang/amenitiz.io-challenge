# frozen_string_literal: true

require 'spec_helper'

describe Baskets::AddProductService do
  describe '.call' do
    subject(:add_producto_basket) do
      described_class.call(product)
    end

    let(:product) { create(:product) }

    it 'adds product to basket' do
      expect { add_producto_basket }.to change { Basket.count }.by(1)
    end

    context 'when initiated basket already exist' do
      let!(:basket) { create(:basket) }
      it 'adds product to basket' do
        expect { add_producto_basket }.to change { Basket.count }.by(1)
      end
    end
  end
end
