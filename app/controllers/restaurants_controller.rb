class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    if params[:search].present?
      @menu_items = @restaurant&.menu_items.
                  where("category LIKE ?","%#{ params[:search]}%")
                  .or(@restaurant&.menu_items.where("name LIKE ?","%#{ params[:search]}%"))
    else
      @menu_items = @restaurant.menu_items
    end 
  end
end
