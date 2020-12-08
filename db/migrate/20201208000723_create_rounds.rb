class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.belongs_to :room, null: false, foreign_key: { to_table: :rooms }

      t.timestamps
    end
  end
end
