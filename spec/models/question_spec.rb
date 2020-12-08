# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Question, type: :model do
  context "validations" do
    it { should validate_presence_of(:title) }
  end

  context "relations" do
    it { should have_many(:answers) }
    it { should have_many(:rounds) }
  end
end
