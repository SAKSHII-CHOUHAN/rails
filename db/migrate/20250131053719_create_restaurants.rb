class CreateRestaurants < ActiveRecord::Migration[8.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :address
      t.string :owner_name
      t.string :owner_email
      t.timestamps
    end
  end
end
