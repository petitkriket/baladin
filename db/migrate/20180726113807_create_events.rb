class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :address
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :photo
      t.references :passenger, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :published

      t.timestamps
    end
  end
end
