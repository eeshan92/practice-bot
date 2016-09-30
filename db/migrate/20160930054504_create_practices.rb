class CreatePractices < ActiveRecord::Migration[5.0]
  def change
    create_table :practices do |t|
      t.datetime :date
      t.time :start
      t.time :end
      t.integer :status

      t.timestamps
    end
  end
end
