class Api::V1::GifsController < ApplicationController
  def show
    validate :current_location do
      daily_forecasts = Forecast.for_location(current_location).daily
      forecast_gifs = Giforecast.for_forecast(daily_forecasts, current_location)
      render json: GiforecastSerializer.new(forecast_gifs)
    end
  end
end
