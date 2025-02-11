require 'stripe'
class PaymentsController < ApplicationController
  before_action :set_order

  def new
    @amount = @order.total_amount.to_i
  end

  def create
    begin
      customer =  Stripe::Customer.create({
        name: @order.customer_name,
        email: @order.customer_email,
      })
      payment_intent = Stripe::PaymentIntent.create({
        amount: @order.total_amount.to_i, 
        customer: customer.id,
        currency: 'usd',
        payment_method: params[:payment_method_id],
        confirmation_method: 'manual', 
        confirm: true,
        return_url: 'https://dashboard' 
      })

      if payment_intent.status == 'succeeded'
        @order.update(status: 'paid')

        Stripe::InvoiceItem.create({
          customer: customer.id,
          amount: @order.total_amount.to_i,
          currency: 'usd',
          description: "Invoice for Order ##{@order.id}",
        })

        invoice = Stripe::Invoice.create({
          customer: customer.id,
          auto_advance: true,
        })
        Rails.logger.info("Invoice created: #{invoice.inspect}")
        invoice.finalize_invoice

        redirect_to dashboard_index_path, notice: 'Payment successful!'
      else
        flash[:alert] = 'Payment failed. Please try again.'
        redirect_to new_payment_path
      end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_payment_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
