class RenameQuestionIdToQuestionTemplateIdOnRound < ActiveRecord::Migration[6.0]
  def change
    rename_column :rounds, :question_id, :question_template_id
  end
end
