class AddPracticeStartAndEnd < ActiveRecord::Migration[5.0]
  def change
    add_column :practices, :start, :datetime
    add_column :practices, :end, :datetime
  end
end
