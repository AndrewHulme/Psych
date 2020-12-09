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
FactoryBot.define do
  factory :question do
    title { "What caused %{name} to say, \"#{Faker::Quote.unique.famous_last_words}\"?" }
  end
end
