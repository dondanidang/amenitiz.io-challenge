class CreateQuantityBasedDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :quantity_based_discounts do |t|
      t.integer :discount_value, null: false
      t.string :discount_unit, null: false
      t.integer :quantity, null: false
      t.string  :operator, null: false
      t.timestamps
    end
  end
end
