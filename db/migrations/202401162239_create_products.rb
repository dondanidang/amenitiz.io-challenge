class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :description, null: false
      t.integer :price_cents, null: false
      t.string :price_currency, null: false, default: 'EUR'
      t.timestamps
    end
  end
end
