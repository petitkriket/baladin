class EditEventsFk < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :events, column: :user_id
    add_foreign_key :events, :users, column: :user_id, on_delete: :nullify
  end
end
