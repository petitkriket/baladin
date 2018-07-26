class AddSlugToPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :passengers, :slug, :string
    add_index :passengers, :slug, unique: true
  end
end
