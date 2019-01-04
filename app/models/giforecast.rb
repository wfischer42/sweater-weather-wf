class Giforecast
  def initialize()

  end

  def self.for_forecast(daily_forecast)
    raw_gifs = daily_forecast.map do |forecast, i|
      forecast[:url] = GiffyService.get_gif(forecast[:summary])
      forecast.slice(:time, :summary, :url)
    end
  end
end
