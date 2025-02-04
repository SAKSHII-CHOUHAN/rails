class OrdersController < ApplicationController

  def index
    @orders = current_user.restaurant.orders
  end

  def create
    table = Table.find(params[:table_id])
    # order = Order.create!(
    #   table: table,
    #   total_amount: 0,
    #   status: "pending",
    #   restaurant_id: table.restaurant_id
    # )
    order = table.orders.find_or_create_by(status: "pending", restaurant_id: table.restaurant_id) 
    total_price = 0

    params[:order][:items].each do |menu_item_id, quantity|
      quantity = quantity.to_i
      next if quantity.zero?

      menu_item = MenuItem.find(menu_item_id)
      price = menu_item.price * quantity
      total_price += price

      order.order_items.create!(
        name: menu_item.name,
        quantity: quantity,
        amount: price
      )
    end

    order.update(total_amount: total_price)
  
    table.update(table_status: "occupied")
    redirect_to table_path(table), notice: "Order placed successfully!"
  end
  
  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order&.id)
    @total_amount = @order_items.pluck(:amount).sum
  end

  def update
    @order = Order.find(params[:id])

    @order.update(status: 'completed')
    table = @order.table
    table.update(table_status: "unoccupied")
    byebug
    redirect_to order_path(@order), notice: 'Order completed successfully.'
  end 
end
