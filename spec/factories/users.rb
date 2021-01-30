# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           default("Player")
#  ready_for_next_round   :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  visitor_key            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  room_id                :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token)
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_room_id               (room_id)
#  index_users_on_visitor_key           (visitor_key) UNIQUE
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
