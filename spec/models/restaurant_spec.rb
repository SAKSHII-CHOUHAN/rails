require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:owner_email) }
    it { should validate_presence_of(:owner_name) }
  end

  describe 'associations' do
    it { should have_many(:users).dependent(:destroy) }
    it { should have_many(:tables).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:menu_items).dependent(:destroy) }
    it { should have_many(:feedbacks).dependent(:destroy) }
    it { should have_one(:admin_user).dependent(:destroy) }
  end
end
