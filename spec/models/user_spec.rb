# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
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
require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_uniqueness_of(:visitor_key).case_insensitive }
  end
end
