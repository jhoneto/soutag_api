# frozen_string_literal: true

class RefuelingsController < ApplicationController
  def create
    refueling = Refueling::CreateService.call(refueling_params)

    if refueling.success?
      render json: refueling, status: :created
    else
      render json: { error: refueling.error }, status: :unprocessable_entity
    end
  end
end
