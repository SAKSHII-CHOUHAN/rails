class OrderMailer < ApplicationMailer
  default from: 'your-email@example.com'
  
  def confirmation_email
    @order = params[:order]

    mail(to: @order.customer_email, subject: 'Order Confirmation')
  end
end
