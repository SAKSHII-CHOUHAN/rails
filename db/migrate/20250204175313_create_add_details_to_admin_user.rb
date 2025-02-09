class AddDetailsToAdminUser < ActiveRecord::Migration[8.0]
  def change
    add_column :admin_users, :role, :integer
    add_reference :admin_users, :restaurant, null: true
  end
end
