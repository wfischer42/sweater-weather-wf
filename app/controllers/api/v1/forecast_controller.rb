class Api::V1::ForecastController < ApplicationController
  def show
    location = Location.fetch(forecast_params)
    forecast = Forecast.for_city_state(location)
    render json: ForecastSerializer.new(forecast)
  end

  private
  def forecast_params
    params.permit(:city, :state)
  end
end
