class Restaurant < ApplicationRecord
  has_many :user
  has_many :table
  has_many :orders
  has_many :menu_items
end
