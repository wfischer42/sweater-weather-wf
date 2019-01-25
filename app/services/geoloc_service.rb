class GeolocService
  def initialize(location_query)
    @location_query = location_query
  end

  def self.location_data(location_query)
    service = new(location_query)
    service.get_location_data
  end

  def get_location_data
    parsed = JSON.parse(response.body, symbolize_names: true)


    location = location_structure(parsed[:resourceSets][0][:resources][0])
    # An invalid location returns "United States" as the response location
    # This replaces it with an empty hash
    # (location[:name] == "United States") ? Hash.new : location
  end

  private
  attr_reader :location_query

  def location_structure(data)
    return {} if data == nil
    location = Hash.new
    location[:name] = data[:name]
    location[:lat]  = data[:point][:coordinates][0]
    location[:lon]  = data[:point][:coordinates][1]
    location[:city] = data[:address][:locality]
    location[:state] = data[:address][:adminDistrict]
    location[:country] = data[:address][:countryRegion]
    return location
  end

  def response
    conn.get('REST/v1/Locations/' + location_query)
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

# For Zip
# :address=>
#   {:adminDistrict=>"CO",   **** State
#    :adminDistrict2=>"Denver County",
#    :countryRegion=>"United States",
#    :formattedAddress=>"80231, CO",
#    :locality=>"Denver",    **** City
#    :postalCode=>"80231"},

# For city/state
# :address=>
#   {:adminDistrict=>"CO",   **** State
#    :adminDistrict2=>"Denver County",
#    :countryRegion=>"United States",
#    :formattedAddress=>"Denver, CO",
#    :locality=>"Denver"},   **** City

# for invalid
# :address=>{:countryRegion=>"United States", :formattedAddress=>"United States"},
