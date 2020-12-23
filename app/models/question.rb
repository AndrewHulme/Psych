# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_questions_on_title  (title) UNIQUE
#
class Question < ApplicationRecord
  has_many :rounds, foreign_key: :question_template_id

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def format(user = nil)
    title % { name: user&.name }
  end
end
