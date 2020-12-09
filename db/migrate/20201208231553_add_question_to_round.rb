class AddQuestionToRound < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :question, :string
  end
end
