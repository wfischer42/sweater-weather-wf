class AddLocationQueryToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :location_query, :string
  end
end
