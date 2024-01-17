class CreateMigrations < ActiveRecord::Migration[7.1]
  def change
    create_table :migrations do |t|
      t.string :name, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
