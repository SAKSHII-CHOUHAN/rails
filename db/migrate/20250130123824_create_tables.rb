class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.string :table_number
      t.integer :guest_quantity
      t.integer :table_status
      t.references :restaurant
      t.timestamps
    end
  end
end
