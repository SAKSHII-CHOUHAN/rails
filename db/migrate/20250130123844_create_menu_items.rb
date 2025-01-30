class CreateMenuItems < ActiveRecord::Migration[8.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price 
      t.string :category
      t.text :description
      t.boolean :availability_status
      t.belongs_to :menu
      t.timestamps
    end
  end
end
