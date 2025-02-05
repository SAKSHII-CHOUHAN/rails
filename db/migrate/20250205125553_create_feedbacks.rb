class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.text :comments
      t.references :restaurant
      t.timestamps
    end
  end
end
