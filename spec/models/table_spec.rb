require 'rails_helper'

RSpec.describe Table, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:table_number) }
    it { should validate_presence_of(:table_status) }
    it { should validate_presence_of(:guest_quantity) }
  end

  describe 'associations' do
    it { should have_many(:orders) }
    it { should belong_to(:restaurant) }
  end
end
