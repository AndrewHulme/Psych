# == Schema Information
#
# Table name: rooms
#
#  id          :bigint           not null, primary key
#  name        :string
#  password    :string
#  round_count :integer          default(3)
#  status      :integer          default("draft"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  host_id     :bigint           not null
#
# Indexes
#
#  index_rooms_on_host_id   (host_id)
#  index_rooms_on_password  (password) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (host_id => users.id)
#
FactoryBot.define do
  factory :room do
    association :host, factory: :user, strategy: :create
    name { Faker::Restaurant.name }
    password { "pw_#{SecureRandom.hex}" }
    round_count { 3 }
    status { 0 }

    factory :startable_room do
      after(:create, :build) do |room, _|
        (Room::MIN_PLAYER_COUNT - 1).times do
          create :user, room: room
        end
      end
    end
  end
end
