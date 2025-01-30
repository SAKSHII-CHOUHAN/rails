class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.string :name
      t.text :description
      t.integer :quantity 
      t.decimal :amount
      t.belongs_to :order
      t.timestamps
    end
  end
end
