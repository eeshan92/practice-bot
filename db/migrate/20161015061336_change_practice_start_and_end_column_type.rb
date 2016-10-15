class ChangePracticeStartAndEndColumnType < ActiveRecord::Migration[5.0]
  def up
    remove_column :practices, :start
    remove_column :practices, :end
  end
end