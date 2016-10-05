class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :practice, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment
      t.integer :status

      t.timestamps
    end
  end
end
