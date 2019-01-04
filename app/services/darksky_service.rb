class DarkskyService
  def initialize(location)
    @lat = location[:lat]
    @lon = location[:lon]
  end

  def self.forecast(location)
    service = new(location)
    service.get_forecast
  end

  def get_forecast
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  attr_reader :lat, :lon

  def response
    @response ||= conn.get("#{lat},#{lon}") do |request|
      request.params["exclude"] = "minutely"
    end
  end

  def conn
    darksky_path = "https://api.darksky.net/forecast/#{ENV['DARKSKY_KEY']}/"
    Faraday.new(darksky_path)
  end
end
