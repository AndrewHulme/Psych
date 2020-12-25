class AddReadyForNextRoundToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ready_for_next_round, :boolean
  end
end
