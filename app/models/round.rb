# == Schema Information
#
# Table name: rounds
#
#  id                   :bigint           not null, primary key
#  question             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  question_template_id :bigint
#  room_id              :bigint           not null
#  subject_id           :bigint
#
# Indexes
#
#  index_rounds_on_question_template_id  (question_template_id)
#  index_rounds_on_room_id               (room_id)
#  index_rounds_on_subject_id            (subject_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_template_id => questions.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (subject_id => users.id)
#
class Round < ApplicationRecord
  belongs_to :room
  belongs_to :question_template, class_name: "Question", foreign_key: "question_template_id"
  belongs_to :subject, class_name: "User", foreign_key: "subject_id"
  has_many :answers

  validates :question, :room_id, :question_template_id, presence: true

  before_validation :prepare_question, on: :create

  def all_votes_submitted?
    Vote.where(answer: answers).count == answers.count
  end

  private

  def prepare_question
    # maybe check to ensure that question hasnt already been used in the current round
    self.question_template = random_question
    self.subject = random_room_user
    self.question = question_template.format(subject)
  end

  def random_question
    Question.order(Arel.sql('RANDOM()')).first
  end

  def random_room_user
    room.users.sample
  end
end
