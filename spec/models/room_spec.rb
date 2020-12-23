# == Schema Information
#
# Table name: rooms
#
#  id               :bigint           not null, primary key
#  name             :string
#  password         :string
#  round_count      :integer          default(3)
#  status           :integer          default("draft"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  current_round_id :bigint
#  host_id          :bigint           not null
#
# Indexes
#
#  index_rooms_on_current_round_id  (current_round_id)
#  index_rooms_on_host_id           (host_id)
#  index_rooms_on_password          (password) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (current_round_id => rounds.id)
#  fk_rails_...  (host_id => users.id)
#
require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { build :room }
  let(:host) { room.host }

  subject { room }

  context "validations" do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:host_id) }

    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_length_of(:password).is_at_least(3) }

    it { should validate_numericality_of(:round_count).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_uniqueness_of(:password).ignoring_case_sensitivity
      .with_message("is already taken. Please choose a different password.") }
  end

  context "relations" do
    it { should belong_to(:host).class_name("User") }
    it { should belong_to(:current_round).class_name("Round").optional }
    it { should have_many(:users) }
    it { should have_many(:rounds) }
  end

  context "before create" do
    context "when room has no given name" do
      it "auto generates a name" do
        subject.name = nil
        subject.save!

        expect(subject.name).to_not be_nil
        expect(subject.name).to be_a(String)
      end
    end

    context "when room has no given password" do
      it "auto generates a password" do
        subject.password = nil
        subject.save!

        expect(subject.password).to_not be_nil
        expect(subject.password).to be_a(String)
      end
    end
  end

  context "after create" do
    it "updates status to :awaiting_players" do
      expect(subject.status).to eq("draft")

      subject.save!

      expect(subject.status).to eq("awaiting_players")
    end
  end
end
