class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :visitor_key

      t.timestamps
    end

    add_index :users, :visitor_key,                unique: true
  end
end
