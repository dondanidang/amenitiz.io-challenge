class CreateBaskets < ActiveRecord::Migration[7.1]
  def change
    create_table :baskets do |t|
      t.string :status, null: false
      t.integer :total_cents, null: false
      t.string :total_urrency, null: false, default: 'EUR'
      t.integer :total_paid_cents, null: false
      t.string :total_paid_currency, null: false, default: 'EUR'
      t.timestamps
    end
  end
end
