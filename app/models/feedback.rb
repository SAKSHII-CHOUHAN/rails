class Feedback < ApplicationRecord
  belongs_to :restaurant
  
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :comments, presence: true
end
