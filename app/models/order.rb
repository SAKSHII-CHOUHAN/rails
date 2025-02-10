class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  belongs_to :table
  belongs_to :restaurant

  enum :status, [ :pending, :completed, :paid]
end
