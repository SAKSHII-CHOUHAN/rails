class TablesController < ApplicationController
  def index 
    @tables = current_user.restaurant.tables
  end

  def show
     @table = Table.find(params[:id])
     @menu_items = current_user.restaurant.menu_items
     @order = @table.orders.where(status: "pending").last
     @order_items = OrderItem.where(order_id: @order&.id)
  end
end
