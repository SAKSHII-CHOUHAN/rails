class Table < ApplicationRecord
  has_many :orders
  belongs_to :restaurant

  enum :table_status, [ :occupied, :unoccupied ]
end
