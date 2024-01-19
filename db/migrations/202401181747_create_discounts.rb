class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :description, null: false
      t.references :rulable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
