class CreateMeterReadings < ActiveRecord::Migration[5.2]

  def up
    create_table :meter_readings do |t|
      t.integer :meter_id, null: false
      t.decimal :consumption, precision: 10, scale: 6, null: false
      t.datetime :timestamp, null: false
      t.timestamps
    end
  end

  def down
    drop_table :meter_readings
  end

end
