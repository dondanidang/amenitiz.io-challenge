class CreateQuantityBasedDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :quantity_based_discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :discount_value, null: false
      t.string :discount_type, null: false
      t.timestamps
    end
  end
end
