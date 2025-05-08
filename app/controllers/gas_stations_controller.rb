class GasStationsController < ApplicationController
  before_action :set_gas_station, only: [ :show, :update, :destroy ]

  # GET /gas_stations
  def index
    @gas_stations = GasStation.all
    render json: @gas_stations
  end

  # GET /gas_stations/:id
  def show
    render json: @gas_station
  end

  # POST /gas_stations
  def create
    @gas_station = GasStation.new(gas_station_params)
    if @gas_station.save
      render json: @gas_station, status: :created
    else
      render json: @gas_station.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gas_stations/:id
  def update
    if @gas_station.update(gas_station_params)
      render json: @gas_station
    else
      render json: @gas_station.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gas_stations/:id
  def destroy
    @gas_station.destroy
    head :no_content
  end

  private

  # Callback to set gas station for show, update, and destroy actions
  def set_gas_station
    @gas_station = GasStation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Gas station not found" }, status: :not_found
  end

  # Strong parameters
  def gas_station_params
    params.require(:gas_station).permit(:name, :address, :price_per_liter)
  end
end
