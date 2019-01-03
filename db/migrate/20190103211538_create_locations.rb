class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.decimal :lat
      t.decimal :lon

      t.timestamps
    end
  end
end
