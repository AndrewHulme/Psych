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
FactoryBot.define do
  factory :round do
    association :question_template, factory: :question
    association :room, factory: :startable_room
  end
end
