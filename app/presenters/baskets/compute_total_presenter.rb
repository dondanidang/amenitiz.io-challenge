# frozen_string_literal: true

module Baskets
  class ComputeTotalPresenter < PartialPresenter
    private

    def build_view
      build_view_raw
        .merge(
          total: @basket.total.format,
          total_with_discount: @basket.total_paid.format
        ).to_yaml
    end
  end
end
