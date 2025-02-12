class TablesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tables = current_user&.restaurant&.tables
  end

  def show
    @table = Table.find(params[:id])
    if params[:search].present?
      @menu_items = current_user&.restaurant&.menu_items
      .where("category ILIKE ?", "%#{params[:search]}%")
      .or(current_user&.restaurant&.menu_items.where("name ILIKE ?", "%#{params[:search]}%"))
      .paginate(page: params[:page], per_page: 1)
    else
      @menu_items = current_user.restaurant.menu_items.paginate(page: params[:page], per_page: 4)
    end
    @order = @table&.orders.where(status: "pending").last
    @order_items = OrderItem.where(order_id: @order&.id)
  end
end
