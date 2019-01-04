class GeolocService
  def initialize(city:, state:)
    @city = city
    @state = state
  end

  def self.coordinates(city:, state:)
    service = new(city: city, state: state)
    service.get_coordinates
  end

  def get_coordinates
    parsed = JSON.parse(response.body, symbolize_names: true)
    return Hash.new if parsed[:Results].empty?

    coords = parsed[:Results].first.slice(:lat, :lon)
    coords.map { |key, value| [key, value.to_f] }.to_h
  end

  private
  attr_reader :city, :state
  def response
    @response ||= conn.get('latlon.php') do |req|
      req.params['location'] = [city, state].join(',')
    end
  end

  def conn
    path = "https://devru-latitude-longitude-find-v1.p.mashape.com/"
    Faraday.new(path) do |faraday|
      faraday.headers['X-Mashape-Key'] = ENV["X_MASHAPE_KEY"]
      faraday.adapter Faraday.default_adapter
    end
  end
end
