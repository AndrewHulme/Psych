class CreateAllowlistedJwts < ActiveRecord::Migration[6.0]
  def change
    create_table :allowlisted_jwts do |t|
      t.string :jti, null: false
      t.string :aud
      # If you want to leverage the `aud` claim, add to it a `NOT NULL` constraint:
      # t.string :aud, null: false
      t.datetime :exp, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    add_index :allowlisted_jwts, :jti, unique: true
  end
end
