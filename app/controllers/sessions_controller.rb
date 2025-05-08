# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.id.nil?
      render json: { error: "Invalid credentials" }, status: :unauthorized
    else
      render json: {
        id: resource.id,
        name: resource.name,
        balance: resource.balance,
        email: resource.email
      }
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
