class Api::V1::ForecastController < ApplicationController
  def show
    if location = Location.fetch(location_params)
      full_forecast = Forecast.for_location(location)
      render json: ForecastSerializer.new(full_forecast)
    else
      render json: { message: "Location was not found." }
    end
  end
end
