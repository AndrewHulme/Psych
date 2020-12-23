class AddCurrentRoundToRooms < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :current_round, null: true, foreign_key: { to_table: :rounds }
  end
end
