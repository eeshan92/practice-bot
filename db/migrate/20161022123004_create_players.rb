class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :handle
      t.string :foreign_id
      t.integer :gender
      t.timestamps
    end
  end
end
