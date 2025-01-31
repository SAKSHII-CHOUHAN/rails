class TablesController < ApplicationController
  def index 
    @tables = current_user.restaurant.tables
  end
end
