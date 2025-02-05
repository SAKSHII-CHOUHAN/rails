class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :table
  belongs_to :restaurant
  enum :status, [ :pending, :completed ]

  # validates :order_items, presence: true
  validate :order_items_present
  private
  
  def order_items_present
    if order_items.empty?
      errors.add(:order_items, "must have at least one item")
    end
  end
end
