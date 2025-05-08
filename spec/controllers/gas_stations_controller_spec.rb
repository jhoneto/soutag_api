require 'rails_helper'

RSpec.describe "GasStationsController", type: :request do
  let!(:gas_station) { create(:gas_station) }
  let(:valid_attributes) { { name: "Test Gas Station", address: "123 Main St", price_per_liter: 5.99 } }
  let(:invalid_attributes) { { name: "", address: "", price_per_liter: -1 } }
  let(:auth_headers) { authenticated_header(create(:user)) }

  describe "GET /gas_stations" do
    before { get "/gas_stations", headers: auth_headers }

    it "returns a success response" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct number of gas stations" do
      expect(JSON.parse(response.body).size).to eq(GasStation.count)
    end
  end

  describe "GET /gas_stations/:id" do
    context "when the gas station exists" do
      before { get "/gas_stations/#{gas_station.id}", headers: auth_headers }

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct gas station data" do
        expect(JSON.parse(response.body)["id"]).to eq(gas_station.id)
      end
    end

    context "when the gas station does not exist" do
      before { get "/gas_stations/9999", headers: auth_headers }

      it "returns a not found response" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns the correct error message" do
        expect(JSON.parse(response.body)["error"]).to eq("Gas station not found")
      end
    end
  end

  describe "POST /gas_stations" do
    context "with valid attributes" do
      before { post "/gas_stations", params: { gas_station: valid_attributes }.to_json, headers: auth_headers }

      it "creates a new gas station" do
        expect(GasStation.count).to eq(2)
      end

      it "returns a created status" do
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      before { post "/gas_stations", params: { gas_station: invalid_attributes }.to_json, headers: auth_headers }

      it "does not create a new gas station" do
        expect(GasStation.count).to eq(1)
      end

      it "returns an unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT /gas_stations/:id" do
    context "with valid attributes" do
      before { patch "/gas_stations/#{gas_station.id}", params: { gas_station: { name: "Updated Name" } }.to_json, headers: auth_headers }

      it "updates the gas station" do
        expect(gas_station.reload.name).to eq("Updated Name")
      end

      it "returns a success status" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      before { patch "/gas_stations/#{gas_station.id}", params: { gas_station: { price_per_liter: -1 } }.to_json, headers: auth_headers }

      it "does not update the gas station" do
        expect(gas_station.reload.price_per_liter).not_to eq(-1)
      end

      it "returns an unprocessable entity status" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /gas_stations/:id" do
    context "when the gas station exists" do
      before { delete "/gas_stations/#{gas_station.id}", headers: auth_headers }

      it "deletes the gas station" do
        expect(GasStation.exists?(gas_station.id)).to be_falsey
      end

      it "returns a no content status" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the gas station does not exist" do
      before { delete "/gas_stations/9999", headers: auth_headers }

      it "returns a not found response" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns the correct error message" do
        expect(JSON.parse(response.body)["error"]).to eq("Gas station not found")
      end
    end
  end
end
