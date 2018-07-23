class CreateMonthlyTargets < ActiveRecord::Migration[5.2]

  def up
    create_table :monthly_targets do |t|
      t.integer :meter_id, null: false
      t.integer :month, null: false
      t.decimal :consumption, precision: 10, scale: 6
      t.timestamps
    end
  end

  def down
    drop_table :monthly_targets
  end

end
