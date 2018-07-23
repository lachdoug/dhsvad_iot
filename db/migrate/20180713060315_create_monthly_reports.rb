class CreateMonthlyReports < ActiveRecord::Migration[5.2]

  def up
    create_table :monthly_reports do |t|
      t.integer :meter_id, null: false
      t.decimal :consumption, precision: 10, scale: 6
      t.decimal :target, precision: 10, scale: 6
      t.datetime :timestamp, null: false
      t.timestamps
    end
  end

  def down
    drop_table :monthly_reports
  end

end
