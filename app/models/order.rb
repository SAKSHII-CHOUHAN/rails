class Order < ApplicationRecord
  validates :customer_name, presence: true
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  has_many :order_items, dependent: :destroy
  
  belongs_to :table
  belongs_to :restaurant

  enum :status, [ :pending, :completed, :paid]
   
  after_create :send_confirmation_email

  private

  def send_confirmation_email
    OrderConfirmationJob.perform_later(self)
  end
end
