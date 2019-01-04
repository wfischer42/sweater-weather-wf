class Location < ApplicationRecord
  validates :lat, numericality: { greater_than_or_equal_to:  -90,
                                  less_than_or_equal_to:      90 }
  validates :lon, numericality: { greater_than_or_equal_to: -180,
                                  less_than_or_equal_to:     180 }

  def self.fetch(params)
    location = find_or_initialize_by(params)
    location.get_coordinates(params) unless location.persisted?
    location.save ? location : nil
  end

  def get_coordinates(params)
    coords = GeolocService.coordinates(city:  params[:city],
                                       state: params[:state])
    self.lat = coords[:lat]
    self.lon = coords[:lon]
  end
end
