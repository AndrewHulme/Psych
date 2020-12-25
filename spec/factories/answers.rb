# == Schema Information
#
# Table name: answers
#
#  id         :bigint           not null, primary key
#  answer     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  round_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_answers_on_round_id  (round_id)
#  index_answers_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (round_id => rounds.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :answer do
    answer { Faker::Quote.most_interesting_man_in_the_world }
    association :user
    association :round
  end
end
