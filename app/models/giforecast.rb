class Giforecast
  def initialize(raw_gifs)

  end

  def self.for_forecast(daily_forecast, location)
    raw_gifs = daily_forecast.map do |forecast, i|
      forecast[:url] = GiffyService.get_gif(forecast[:summary])
      forecast.slice(:time, :summary, :url)
    end
    self.new(raw_gifs)
  end
end
