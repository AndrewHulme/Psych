class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_reference :rounds, :question, foreign_key: true
  end
end
