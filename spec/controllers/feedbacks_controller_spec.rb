require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do

  # let(:signed_in_user) { create(:user) }

  # before do
  #   signed_in_admin_user
  # end
  
  describe "GET #index" do
    let!(:restaurant) { create(:restaurant) }
    let!(:all_feedback) { create(:feedback, restaurant: restaurant) }

    it "assigns @feedbacks" do
      get :index
      expect(assigns(:feedbacks)).to eq(all_feedback)
    end
  end
end