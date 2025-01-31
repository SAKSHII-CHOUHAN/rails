class MenuItemsController < ApplicationController
  def index
    # @restaurant = current_user.restaurant
    @menu_items = current_user.restaurant.menu_items
  end
end
