class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrderMailer.with(order: order).confirmation_email.deliver_now
  end
end
