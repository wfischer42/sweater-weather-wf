class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :favorite,
             class_name: "Location",
             foreign_key: "location_id"
end
