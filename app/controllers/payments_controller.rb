class PaymentsController < ApplicationController
  def new
    @order = Order.find(params[:id])

    razorpay_order = Razorpay::Order.create(
      amount: (@order.total_amount * 100).to_i, # Convert to paise
      currency: 'INR',
      receipt: "order_#{@order.id}",
      payment_capture: 1
    )

    @razorpay_order_id = razorpay_order.id
    @razorpay_key = ENV['RAZORPAY_KEY_ID']
  end

  def create
    order = Order.find(params[:order_id])
    payment = Razorpay::Payment.fetch(params[:razorpay_payment_id])

    if payment.status == "captured"
      order.update(status: "paid")
      flash[:notice] = "Payment successful!"
      redirect_to order_path(order)
    else
      flash[:alert] = "Payment failed! Try again."
      redirect_to new_payment_path(id: order.id)
    end
  end
end
