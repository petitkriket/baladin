class RemoveTokenFromPassengers < ActiveRecord::Migration[5.2]
  def change
    remove_column :passengers, :token, :string
  end
end
