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
require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_uniqueness_of(:visitor_key).case_insensitive }
  end
end
