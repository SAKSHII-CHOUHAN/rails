class Table < ApplicationRecord
  has_many :orders
  belongs_to :restaurant

  validates :table_number, :table_status, :guest_quantity, presence: true
 
  enum :table_status, [ :occupied, :unoccupied ]
end
