class Giforecast < SimpleDelegator
  attr_reader :daily_forecasts

  def initialize(forecasts_gif_data, location)
    @daily_forecasts = forecasts_gif_data
    @location = location
  end

  def self.for_forecast(daily_forecasts_data, location)
    forecasts_gif_data = daily_forecasts_data.map do |forecast, i|
      forecast[:url] = GiffyService.get_gif(forecast[:summary])
      forecast.slice(:time, :summary, :url)
    end
    self.new(forecasts_gif_data, location)
  end

  def id
    location.id
  end

  def copyrite
    Date.today.year
  end

  private
  attr_reader :location
end
