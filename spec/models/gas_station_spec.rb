require 'rails_helper'

RSpec.describe GasStation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_numericality_of(:price_per_liter).is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should have_many(:refuelings) }
  end
end
