class AddStatusToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :status, :integer
  end
end
