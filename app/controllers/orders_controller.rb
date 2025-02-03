class OrdersController < ApplicationController

  def index
    @orders = current_user.restaurant.orders
  end

  def create
    table = Table.find(params[:table_id])
    order = Order.create!(
      table: table,
      customer_name: params[:order][:customer_name],
      customer_contact: params[:order][:customer_contact],
      total_amount: 0,
      status: "pending",
      restaurant_id: table.restaurant_id
    )

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

    redirect_to table_path(table), notice: "Order placed successfully!"
  end
end

# private

# def order_params
#   params.require(:order).permit(:customer_name, :customer_contact, :status, :total_amount, :restaurant_id, :table_id)
# end
