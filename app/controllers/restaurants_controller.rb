class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    @menu_items = @restaurant.menu_items
  end
end
