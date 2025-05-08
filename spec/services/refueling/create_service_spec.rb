require 'rails_helper'

RSpec.describe Refueling::CreateService do
  let(:user) { create(:user) }
  let(:gas_station) { create(:gas_station, price_per_liter: 5.0) }
  let(:valid_params) { { user_id: user.id, gas_station_id: gas_station.id, liters: 10 } }
  let(:invalid_params) { { user_id: nil, gas_station_id: nil, liters: -5 } }

  describe "#call" do
    context "when the parameters are valid" do
      it "creates a refueling record" do
        result = described_class.call(valid_params)
        expect(Refueling.count).to eq(1)
      end

      it "returns a successful result" do
        result = described_class.call(valid_params)
        expect(result.success).to be_truthy
      end

      it "calculates the correct total cost" do
        result = described_class.call(valid_params)
        expect(result.data.total_cost).to eq(50.0)
      end

      it "applies the correct discount" do
        result = described_class.call(valid_params)
        expect(result.data.discount).to eq(2.5)
      end
    end

    context "when the parameters are invalid" do
      it "does not create a refueling record" do
        result = described_class.call(invalid_params)
        expect(Refueling.count).to eq(0)
      end

      it "returns an unsuccessful result" do
        result = described_class.call(invalid_params)
        expect(result.success).to be_falsey
      end

      it "returns the correct error message" do
        result = described_class.call(invalid_params)
        expect(result.error).to include("Couldn't find GasStation without an ID")
      end
    end
  end
end
