class AddQuestionSubjectToRound < ActiveRecord::Migration[6.0]
  def change
    add_reference :rounds, :subject, null: true, foreign_key: { to_table: :users }
  end
end
