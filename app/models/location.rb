class Location < ApplicationRecord
  validates :lat, numericality: { greater_than_or_equal_to:  -90,
                                  less_than_or_equal_to:      90 }
  validates :lon, numericality: { greater_than_or_equal_to: -180,
                                  less_than_or_equal_to:     180 }

  def self.fetch(params)
    location = find_or_initialize_by(params)
    location.get_location_data(params) unless location.persisted?
    location.save ? location : nil
  end

  def get_location_data(params)
    location_query = params[:location_query].delete(' ').downcase
    location_data = GeolocService.location_data(location_query)
    self.lat  = location_data[:lat]
    self.lon  = location_data[:lon]
    self.name = location_data[:name]
    self.city = location_data[:city]
    self.state = location_data[:state]
    self.country = location_data[:country]
  end
end
