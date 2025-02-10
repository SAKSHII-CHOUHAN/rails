require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:comments) }
  end

  describe 'associations' do
    it { should belong_to(:restaurant) }
  end
end
