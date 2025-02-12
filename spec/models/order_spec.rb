require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:customer_email) }
  end

  describe 'associations' do
    it { should belong_to(:table) }
    it { should belong_to(:restaurant) }
    it { should have_many(:order_items).dependent(:destroy) }
  end
end
