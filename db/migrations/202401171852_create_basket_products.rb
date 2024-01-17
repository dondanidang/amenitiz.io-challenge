class CreateBasketProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :basket_products do |t|
      t.references :basket, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.datetime :removed_at
      t.timestamps
    end
  end
end
