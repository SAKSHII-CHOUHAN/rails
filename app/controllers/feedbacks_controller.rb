class FeedbacksController < ApplicationController
  before_action :set_restaurant

  def index
    @feedbacks = @restaurant.feedbacks.all
  end

  def new
    @feedback = @restaurant.feedback.new
  end

  def create
    @feedback = @restaurant.feedbacks.build(feedback_params)
    if @feedback.save
      redirect_to restaurant_path, notice: 'Thank you for your feedback!'
    else
      render :new
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :comments)
  end
end
