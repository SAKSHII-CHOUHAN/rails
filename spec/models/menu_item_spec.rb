require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:availability_status) }
  end

  describe 'associations' do
    it { should belong_to(:restaurant) }
  end
end
