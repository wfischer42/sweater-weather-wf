class DarkskyService
  def initialize(location)
    @lat = location[:lat]
    @lon = location[:lon]
  end

  def self.get_forecast(location)
    service = new(location)
    service.get_forecast
  end

  def get_forecast
    JSON.parse(response.body, symbolize_names: true)
  end

  private
  attr_reader :lat, :lon

  def response
    @response ||= conn.get('') do |req|
      req.params[''] = lat
      req.params[''] = lon
    end
  end

  def conn
    Faraday.new('url') do |faraday|
      faraday.headers[''] = ENV['DARKSKY_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

end
