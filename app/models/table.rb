class Table < ApplicationRecord
  validates :table_number, presence: true
  validates :table_status, presence: true
  validates :guest_quantity, presence: true

  has_many :orders
  belongs_to :restaurant

  enum :table_status, [ :occupied, :unoccupied ]
end
