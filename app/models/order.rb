class Order < ApplicationRecord
  belongs_to :table
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy

  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  enum :status, [ :pending, :completed, :paid]
   
  after_create :send_confirmation_email

  private

  def send_confirmation_email
    OrderConfirmationJob.perform_later(self)
  end
end
