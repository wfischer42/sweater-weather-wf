module ForecastFilter
  include ActiveSupport::Concern

  def forecast_filter
    [ :time, :icon, :summary, :precipIntensity, :precipProbability, :precipType, :temperature, :apparentTemperature, :temperatureHigh, :temperatureLow, :humidity, :windSpeed, :windGust, :windBearing, :cloudCover, :uvIndex, :visibility ]
  end
end
