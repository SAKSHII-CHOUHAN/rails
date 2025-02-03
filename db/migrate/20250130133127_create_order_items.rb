class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.string :name
      t.integer :quantity 
      t.decimal :amount
      t.references :order
     
      t.timestamps
    end
  end
end
