class AmendAnswerFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :answers, :title, :answer
    remove_reference :answers, :question
  end
end
