class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update]

  def index
    @orders = current_user&.restaurant&.orders&.paginate(page: params[:page], per_page: 6)
  end

  def create
    table = Table.find(params[:table_id])
    order = table&.orders&.find_or_create_by(status: "pending", restaurant_id: table.restaurant_id)
    total_price = 0

    params[:order][:items].each do |menu_item_id, quantity|
      quantity = quantity.to_i
      next if quantity.zero?

      menu_item = MenuItem.find(menu_item_id)
      price = menu_item&.price * quantity
      total_price += price

      order&.order_items&.create!(
        name: menu_item&.name,
        quantity: quantity,
        amount: price
      )
    end

    order.update(total_amount: total_price)

    table.update(table_status: "occupied")
    redirect_to table_path(table)
  end

  def show
    @order_items = OrderItem.where(order_id: @order&.id)
    @total_amount = @order_items&.pluck(:amount).sum
  end

  def update
    @order.update(status: "completed")
    table = @order.table
    table.update(table_status: "unoccupied")
    redirect_to order_path(@order), notice: "Order completed successfully."
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
