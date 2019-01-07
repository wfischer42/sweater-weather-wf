class Giforecast < SimpleDelegator
attr_reader :daily_forecasts

  def initialize(forecast_gifs, location)
    @daily_forecasts = forecast_gifs
    @location = location
  end

  def self.for_forecast(forecast_data, location)
    key = "giforecast_loc_#{location.id}".to_sym
    forecast_gifs = Rails.cache.fetch(key) { get_gifs(forecast_data) }
    self.new(forecast_gifs, location)
  end

  def id
    location.id
  end

  def copyrite
    Date.today.year
  end

  private
  attr_reader :location

  def self.get_gifs(forecast_data)
    forecast_data.map do |forecast, i|
      forecast[:url] = GiffyService.get_gif(forecast[:summary])
      forecast.slice(:time, :summary, :url)
    end
  end
end
