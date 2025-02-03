class DashboardController < ApplicationController
  def index
    @tables = current_user.restaurant.tables
    @menu_items = current_user.restaurant.menu_items
  end
end
