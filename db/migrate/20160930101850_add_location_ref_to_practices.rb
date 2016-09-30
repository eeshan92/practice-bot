class AddLocationRefToPractices < ActiveRecord::Migration[5.0]
  def change
    add_reference :practices, :location, foreign_key: true
  end
end
