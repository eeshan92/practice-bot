class SetDefaultStatuses < ActiveRecord::Migration[5.0]
  def change
    change_column_default :practices, :status, 0
    change_column_default :attendances, :status, 0
    remove_column :attendances, :user_id
  end
end
