class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update]

  def index
    if current_user&.restaurant.present?
      if params[:table_number].present?
        @orders = current_user.restaurant.orders
                  .joins(:table)
                  .where(tables: { table_number: params[:table_number] })
                  .order(created_at: :desc).paginate(page: params[:page], per_page: 6)
      else
        @orders = current_user.restaurant.orders
                  .order(created_at: :desc)
                  .paginate(page: params[:page], per_page: 6)
      end
    else
      @orders = Order.none
    end
  end

  def create
    table = Table.find(params[:table_id])
    @order = table&.orders&.find_or_create_by(
      customer_name: params[:customer_name],
      customer_email: params[:customer_email],
      status: "pending",
      restaurant_id: table.restaurant_id
      )
    total_price = 0

    params[:order][:items].each do |menu_item_id, quantity|
      quantity = quantity.to_i
      next if quantity.zero?

      menu_item = MenuItem.find(menu_item_id)
      price = menu_item&.price * quantity
      total_price += price

      existing_order_item = @order.order_items.find_by(name: menu_item.name)

      if existing_order_item
        existing_order_item.update(quantity: existing_order_item.quantity + quantity, amount: existing_order_item.amount + price)
      else
        @order.order_items.create!(
          name: menu_item.name,
          quantity: quantity,
          amount: price
        )
      end
    end

    if total_price > 0
      @order.update(total_amount: total_price)
      table.update(table_status: "occupied")
      flash[:notice] = "Order created successfully."
      redirect_to table_path(table) 
    else
      @order.destroy if @order.persisted?
      flash[:alert] = "No items selected for the order."
      redirect_to table_path(table)
    end
  end

  def show
    @order_items = OrderItem.where(order_id: @order&.id)
    @total_amount = @order_items&.pluck(:amount).sum
  end

  def update
    @order.update(status: "completed")
    table = @order.table
    table.update(table_status: "unoccupied")
    flash[:notice] = "Order completed successfully."
    redirect_to new_payment_path(id: @order.id)
  end

  def remove_order_item
    order = Order.find(params[:id])
    order_item = order.order_items.find(params[:order_item_id])
  
    order_item.destroy
    new_total = order.order_items.sum(:amount)
    order.update(total_amount: new_total)
  
    flash[:notice] = "Item removed from order."
    redirect_to table_path(order.table)
  end
  
  private

  def set_order
    @order = current_user.restaurant.orders.find_by(id: params[:id])
    redirect_to dashboard_index_path, alert: "Order not found" if @order.nil?
  end
end
