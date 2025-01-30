class CreateMenus < ActiveRecord::Migration[8.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.boolean :active_status
      t.belongs_to :user
      t.timestamps
    end
  end
end
