class TablesController < ApplicationController
  def index 
    @tables = current_user.restaurant.tables
  end

  def show
     @table = Table.find(params[:id])
     @menu_items = current_user.restaurant.menu_items
  end
end
