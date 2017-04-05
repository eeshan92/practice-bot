class AddUserIdToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_reference :players, :user, index: true
  end
end
