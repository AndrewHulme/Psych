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
#  index_rooms_on_host_id  (host_id)
#
# Foreign Keys
#
#  fk_rails_...  (host_id => users.id)
#
FactoryBot.define do
  factory :room do
    name { "MyString" }
    password { "MyString" }
    round_count { 1 }
    status { 1 }
    host_id { nil }
  end
end
