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
require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build :question }

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  context "relations" do
    it { should have_many(:answers) }
    it { should have_many(:rounds).with_foreign_key(:question_template_id) }
  end
end
