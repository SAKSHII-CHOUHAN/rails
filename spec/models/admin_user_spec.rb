require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:email) }
  end

  describe 'associations' do
    it { should belong_to(:restaurant).optional }
  end
end
