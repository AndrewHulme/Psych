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
require 'rails_helper'

RSpec.describe Round, type: :model do
  let(:room) { create :room }
  let(:host) { room.host }
  let!(:user2) { create :user, room: room }
  let!(:user3) { create :user, room: room }
  let!(:question) { create :question }

  subject { create :round }

  context "validations" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:room_id) }
    it { should validate_presence_of(:question_template_id) }
  end

  context "relations" do
    it { should belong_to(:room) }
    it { should belong_to(:question_template).class_name("Question").with_foreign_key(:question_template_id) }
    it { should belong_to(:subject).class_name("User").with_foreign_key(:subject_id) }
    it { should have_many(:answers) }
  end
end
