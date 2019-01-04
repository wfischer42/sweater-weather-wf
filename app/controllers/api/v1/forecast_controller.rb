class Api::V1::ForecastController < ApplicationController
  def show
    if location = Location.fetch(forecast_params)
      forecast = Forecast.for_city_state(location)
      render json: ForecastSerializer.new(forecast)
    else
      render json: { message: "Location was not found." }
    end
  end

  private
  def forecast_params
    params.permit(:city, :state)
  end
end
