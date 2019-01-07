class Api::V1::ForecastController < ApplicationController
  def show
    validate :current_location do
      full_forecast = Forecast.for_location(current_location)
      render json: ForecastSerializer.new(full_forecast)
    end
  end
end
