class Feedback < ApplicationRecord
  belongs_to :restaurant

  validates :name, :comments, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
