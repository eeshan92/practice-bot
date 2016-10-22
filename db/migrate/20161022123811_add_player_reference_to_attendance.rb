class AddPlayerReferenceToAttendance < ActiveRecord::Migration[5.0]
  def down
    remove_column :attendances, :user_id
  end

  def up
    add_reference :attendances, :player, foreign_key: true
  end
end
