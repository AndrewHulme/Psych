# == Schema Information
#
# Table name: users
#
#  id                   :bigint           not null, primary key
#  name                 :string           default("Player")
#  ready_for_next_round :boolean
#  visitor_key          :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  room_id              :bigint
#
# Indexes
#
#  index_users_on_room_id      (room_id)
#  index_users_on_visitor_key  (visitor_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
FactoryBot.define do
  factory :user do
    visitor_key { SecureRandom.hex }
    name { Faker::Name.name }
  end
end
