# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#  round_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_round_id     (round_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#  fk_rails_...  (round_id => rounds.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "validations" do
    it { should validate_presence_of(:title) }
  end

  context "relations" do
    it { should belong_to(:user) }
    it { should belong_to(:round) }
    it { should belong_to(:question) }
    it { should have_many(:votes) }
  end
end
