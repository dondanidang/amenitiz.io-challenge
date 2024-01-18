class CreateQuantityBasedDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :product_discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :discount, null: false, foreign_key: true
      t.datetime :disabled_at
      t.timestamps
    end
  end
end
