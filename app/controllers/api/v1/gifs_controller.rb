class Api::V1::GifsController < ApplicationController
  def show
    if location = Location.fetch(location_params)
      daily_forecasts = Forecast.for_location(location).daily
      forecast_gifs = Giforecast.for_forecast(daily_forecasts, location)
      render json: GiforecastSerializer.new(forecast_gifs)
    else
      render json: { message: "Location was not found." }
    end
  end
end
