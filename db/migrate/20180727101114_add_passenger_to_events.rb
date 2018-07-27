class AddPassengerToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :passenger, foreign_key: true
  end
end
