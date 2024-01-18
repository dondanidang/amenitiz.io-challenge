class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.string :code, null: false
      t.string :description, null: false
      t.references :discountable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
