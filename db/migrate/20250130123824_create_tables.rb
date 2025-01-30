class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.integer :table_nu
      t.integer :guest_quantity
      t.string :table_status
      t.timestamps
    end
  end
end
