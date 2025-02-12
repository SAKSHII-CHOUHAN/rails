class MenuItem < ApplicationRecord
  belongs_to :restaurant

  validates :name, :image, :price, :category, :availability_status, presence: true

  enum :availability_status, [ :available, :unavailable ]

  has_one_attached :image
end
