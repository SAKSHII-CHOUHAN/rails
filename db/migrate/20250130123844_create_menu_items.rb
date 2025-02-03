class CreateMenuItems < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price 
      t.string :category
      t.integer :availability_status
      t.references :restaurant
   
      t.timestamps
    end
  end
end
