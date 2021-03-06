class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :password
      t.integer :round_count, default: 3
      t.integer :status, null: false, default: 0
      t.belongs_to :host, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :rooms, :password, unique: true

    add_reference :users, :room, foreign_key: true
  end
end
