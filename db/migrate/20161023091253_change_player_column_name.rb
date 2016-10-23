class ChangePlayerColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :players, :name, :full_name
  end
end
