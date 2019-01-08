class GeolocService
  def initialize(city:, state:)
    @location_query = city + "," + state
  end

  def self.location_data(city:, state:)
    service = new(city: city, state: state)
    service.get_location_data
  end

  def get_location_data
    parsed = JSON.parse(response.body, symbolize_names: true)
    location = location_structure(parsed[:resourceSets][0][:resources][0])
    # An invalid location returns "United States" as the response location
    # This replaces it with an empty hash
    (location[:name] == "United States") ? Hash.new : location
  end

  private
  attr_reader :location_query

  def location_structure(data)
    location = Hash.new
    location[:name] = data[:name]
    location[:lat]  = data[:point][:coordinates][0]
    location[:lon]  = data[:point][:coordinates][1]
    return location
  end

  def response
    conn.get('REST/v1/Locations/US/' + location_query)
  end

  def conn
    path = "http://dev.virtualearth.net/"
    Faraday.new(path) do |faraday|
      faraday.params['key'] = ENV["BING_MAPS_KEY"]
      faraday.params['maxResults'] = 1
      faraday.adapter Faraday.default_adapter
    end
  end
end
