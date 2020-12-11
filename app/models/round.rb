# == Schema Information
#
# Table name: rounds
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#  room_id     :bigint           not null
#
# Indexes
#
#  index_rounds_on_question_id  (question_id)
#  index_rounds_on_room_id      (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (room_id => rooms.id)
#
class Round < ApplicationRecord
  belongs_to :room
  belongs_to :question
  has_many :answers

  validates :room_id, :question_id, presence: true
end