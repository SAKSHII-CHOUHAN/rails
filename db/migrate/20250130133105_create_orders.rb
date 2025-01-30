class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :contact
      t.string :status
      t.decimal :total_amount 
      t.belongs_to :user
      t.belongs_to :table
      t.timestamps
    end
  end
end
