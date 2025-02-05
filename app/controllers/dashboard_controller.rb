class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @tables = current_user&.restaurant&.tables&.paginate(page: params[:page], per_page: 4)
    @menu_items = current_user&.restaurant&.menu_items&.paginate(page: params[:page], per_page: 4)
  end
end
