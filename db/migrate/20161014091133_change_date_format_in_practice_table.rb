class ChangeDateFormatInPracticeTable < ActiveRecord::Migration[5.0]
  def up
    change_column :practices, :date, :date
  end

  def down
    change_column :practices, :date, :datetime
  end
end
