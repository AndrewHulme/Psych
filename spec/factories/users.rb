# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  visitor_key :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_visitor_key  (visitor_key) UNIQUE
#
FactoryBot.define do
  factory :user do
    visitor_key { "MyString" }
  end
end
