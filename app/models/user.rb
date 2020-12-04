# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string           default("Player")
#  visitor_key :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  room_id     :bigint
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
class User < ApplicationRecord
  MIN_USERNAME_LENGTH = 2
  MAX_USERNAME_LENGTH = 30

  belongs_to :room, optional: true

  validates :visitor_key, uniqueness: { case_sensitive: false }, allow_nil: true
  validates :name, length: { maximum: MIN_USERNAME_LENGTH, maximum: MAX_USERNAME_LENGTH }
end
