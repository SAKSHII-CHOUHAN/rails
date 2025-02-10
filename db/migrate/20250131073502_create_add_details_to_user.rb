class CreateAddDetailsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer
    add_reference :users, :restaurant, null: false, foreign_key: true
  end
end
