class Location < ApplicationRecord
  def self.fetch(params)
    location = find_or_initialize_by(params)
    location.get_coordinates(params) unless location.persisted?
    return location
  end

  def get_coordinates(params)
    coords = GeolocService.coordinates(city:  params[:city],
                                       state: params[:state])
    save if self.lat = coords[:lat] && self.lon = coords[:lon]
  end
end
