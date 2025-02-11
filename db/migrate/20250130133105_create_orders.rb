class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_email
      t.integer :status
      t.decimal :total_amount 
      t.references :restaurant
      t.references :table
      t.timestamps
    end
  end
end
