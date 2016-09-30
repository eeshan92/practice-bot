class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
