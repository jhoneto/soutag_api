require 'rails_helper'

RSpec.describe "RefuelingsController", type: :request do
  let(:user) { create(:user, balance: 100.0) }
  let(:gas_station) { create(:gas_station, price_per_liter: 5.0) }
  let(:valid_params) { { refueling: { user_id: user.id, gas_station_id: gas_station.id, liters: 10 } } }
  let(:invalid_params) { { refueling: { user_id: user.id, gas_station_id: gas_station.id, liters: -5 } } }
  let(:auth_headers) { authenticated_header(user) }

  describe "POST /refuelings" do
    context "with valid parameters" do
      before { post "/refuelings", params: valid_params.to_json, headers: auth_headers }

      it "creates a new refueling" do
        expect(Refueling.count).to eq(1)
      end

      it "returns a created status" do
        expect(response).to have_http_status(:created)
      end

      it "returns the created refueling data" do
        expect(JSON.parse(response.body)["data"]["liters"].to_f).to eq(10)
      end
    end

    context "with invalid parameters" do
      before { post "/refuelings", params: invalid_params.to_json, headers: auth_headers }

      it "does not create a new refueling" do
        expect(Refueling.count).to eq(0)
      end

      it "returns an unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct error message" do
        expect(JSON.parse(response.body)["error"]).to include("must be greater than or equal to 0")
      end
    end

    context "when the user has insufficient balance" do
      before do
        user.update(balance: 10.0) # Set balance lower than required
        post "/refuelings", params: valid_params.to_json, headers: auth_headers
      end

      it "does not create a new refueling" do
        expect(Refueling.count).to eq(0)
      end

      it "returns an unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct error message" do
        expect(JSON.parse(response.body)["error"]).to eq("Insufficient Balance")
      end
    end
  end
end
