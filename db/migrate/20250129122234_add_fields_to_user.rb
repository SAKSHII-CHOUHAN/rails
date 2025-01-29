class AddFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "username"
      t.string "restaurant_name"
      t.string "location"
      t.string "city"
      t.string "state"
      t.string "contact"
      t.timestamps
    end
  end
end
