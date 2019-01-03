class GeolocService
  def initialize(city:, state:)
    @city = city
    @state = state
  end

  def self.coordinates(city:, state:)
    service = new(city: city, state: state)
    service.coordinates
  end

  def coordinates
    {lat: 1.000001, lon: 2.000001}
  end

  private
  attr_reader :city, :state
end
