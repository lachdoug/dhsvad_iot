class CreateMeters < ActiveRecord::Migration[5.2]

  def up
    create_table :meters do |t|
      t.string :name, null: false
      t.text :url, null: false
      t.timestamps
    end
  end

  def down
    drop_table :meters
  end

end
