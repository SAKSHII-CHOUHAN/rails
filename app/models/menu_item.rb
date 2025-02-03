class MenuItem < ApplicationRecord
  belongs_to :restaurant
  enum :availability_status, [:available, :unavailable]
end
