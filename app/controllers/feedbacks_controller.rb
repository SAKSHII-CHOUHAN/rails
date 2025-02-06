class FeedbacksController < ApplicationController
  before_action :set_restaurant, only: [ :index, :new, :create ]

  def index
    @feedbacks = @restaurant.feedbacks.all
  end

  def new
    @feedback = @restaurant.feedbacks.new
  end

  def create
    @feedback = @restaurant.feedbacks.build(feedback_params)
    if @feedback.save
      redirect_to restaurant_path(@restaurant), notice: 'Thank you for your feedback!'
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
