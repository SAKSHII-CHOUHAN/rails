class Feedback < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :comments, presence: true
  
  belongs_to :restaurant
end
