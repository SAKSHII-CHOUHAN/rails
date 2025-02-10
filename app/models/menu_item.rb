class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :availability_status, presence: true

  belongs_to :restaurant
  enum :availability_status, [ :available, :unavailable ]

  has_one_attached :image
end
