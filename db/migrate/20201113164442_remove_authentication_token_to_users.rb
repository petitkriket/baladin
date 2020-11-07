class RemoveAuthenticationTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :authentication_token
    remove_column :users, :authentication_token, :string
  end
end
