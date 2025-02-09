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
    # @orders = current_user&.restaurant&.orders&.paginate(page: params[:page], per_page: 6)
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

    if total_price > 0
      order.update(total_amount: total_price)
      table.update(table_status: "occupied")
      flash[:notice] = "Order created successfully."
      redirect_to table_path(table) 
    else
      order.destroy if order.persisted?
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
    redirect_to order_path(@order)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
