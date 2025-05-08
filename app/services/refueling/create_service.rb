# frozen_string_literal: true

class Refueling::CreateService < BaseService
  def initialize(params)
    @params = params
  end

  def call
    gas_station = GasStation.find(@params[:gas_station_id])
    total_cost = gas_station.price_per_liter * @params[:liters]
    discount = total_cost * Refueling::DEFAULT_DISCOUNT
    user = User.find(@params[:user_id])


    raise StandardError, "Insufficient Balance" if user.balance < (total_cost - discount)

    ActiveRecord::Base.transaction do
      user.update!(balance: user.balance - (total_cost - discount))

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
    end
  rescue StandardError => e
    ServiceResult.new(success: false, error: e.message)
  end
end
