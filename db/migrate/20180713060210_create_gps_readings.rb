class CreateGpsReadings < ActiveRecord::Migration[5.2]

  def up
    create_table :gps_readings do |t|
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.datetime :timestamp, null: false
      t.timestamps
    end
  end

  def down
    drop_table :gps_readings
  end

end
