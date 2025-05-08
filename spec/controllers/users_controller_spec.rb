require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let!(:user) { create(:user) }
  let(:valid_attributes) { { name: "Test User", email: "test@example.com", password: "password", password_confirmation: "password", balance: 100.0 } }
  let(:invalid_attributes) { { name: "", email: "invalid", password: "short", balance: -10 } }
  let(:auth_headers) { authenticated_header(user) }

  describe "GET /users" do
    before do
      get "/users", headers: auth_headers
    end
    it "returns a success response" do
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct number of users" do
      expect(JSON.parse(response.body).size).to eq(User.count)
    end
  end

  describe "GET /users/:id" do
    context "when the user exists" do
      before do
        get "/users/#{user.id}", headers: auth_headers
      end

      it "returns a success response for an existing user" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the correct user data" do
        expect(JSON.parse(response.body)["id"]).to eq(user.id)
      end
    end

    context "when the user does not exist" do
      before do
        get "/users/9999", headers: auth_headers
      end

      it "returns a not found response for a non-existing user" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns the correct error message for a non-existing user" do
        expect(JSON.parse(response.body)["error"]).to eq("User not found")
      end
    end
  end

  describe "POST /users" do
    context "when use valid attributes" do
      before do
        post "/users", params: { user: valid_attributes }
      end
      it "creates a new user with valid attributes" do
        expect(JSON.parse(response.body)["name"]).to eq("Test User")
      end

      it "returns a created status for valid attributes" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when user has invalid attributes" do
      before do
        post "/users", params: { user: invalid_attributes }
      end

      it "returns an unprocessable entity status for invalid attributes" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the correct error message for invalid attributes" do
        expect(JSON.parse(response.body)).to have_key("name")
      end
    end
  end

  describe "PATCH/PUT /users/:id" do
    context "when use valid attributes" do
      before do
        patch "/users/#{user.id}", params: { user: { name: "Updated Name" } }.to_json, headers: auth_headers
      end

      it "updates an existing user with valid attributes" do
        expect(user.reload.name).to eq("Updated Name")
      end

      it "returns a success status for valid attributes" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user has invalid attributes" do
      before do
        patch "/users/#{user.id}", params: { user: { balance: -100 } }.to_json, headers: auth_headers
      end

      it "does not update a user with invalid attributes" do
        expect(user.reload.balance).not_to eq(-100)
      end

      it "returns an unprocessable entity status for invalid attributes" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
