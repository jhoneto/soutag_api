# frozen_string_literal: true

class Refueling::CreateService < BaseService
  def initialize(params)
    @params = params
  end

  def call
    gas_station = GasStation.find(@params[:gas_station_id])
    total_cost = gas_station.price_per_liter * @params[:liters]
    discount = total_cost * Refueling::DEFAULT_DISCOUNT
    refueling = Refueling.new(
      user: User.find_by(id: @params[:user_id]),
      gas_station: gas_station,
      liters: @params[:liters],
      total_cost: total_cost,
      discount: discount
    )
    if refueling.save
      ServiceResult.new(success: true, data: refueling)
    else
      ServiceResult.new(success: false, error: refueling.errors.full_messages.to_sentence)
    end
  rescue StandardError => e
    ServiceResult.new(success: false, error: e.message)
  end
end
