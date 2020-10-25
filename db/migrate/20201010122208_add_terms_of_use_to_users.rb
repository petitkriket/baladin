class AddTermsOfUseToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :terms_of_use, :boolean, default: :false
  end
end
