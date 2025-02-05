class OrderItem < ApplicationRecord
  belongs_to :order
  validates :quantity, numericality: { other_than: 0 }
end
