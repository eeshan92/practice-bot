class AddDetailsToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :email, :string
    add_column :players, :phone, :string
    add_column :players, :NRIC, :string
  end
end
