require 'rails_helper'

RSpec.describe Refueling, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:liters) }
    it { should validate_presence_of(:total_cost) }
    it { should validate_presence_of(:discount) }
    it { should validate_numericality_of(:liters).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:total_cost).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:gas_station) }
  end
end
