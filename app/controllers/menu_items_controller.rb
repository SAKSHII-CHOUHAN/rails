class MenuItemsController < ApplicationController
  def index
    @menu_items = current_user.restaurant.menu_items
  end
end
