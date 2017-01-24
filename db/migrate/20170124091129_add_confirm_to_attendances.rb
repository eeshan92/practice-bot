class AddConfirmToAttendances < ActiveRecord::Migration[5.0]
  def change
    add_column :attendances, :confirm, :boolean, :default => false
  end
end
