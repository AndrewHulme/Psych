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

  describe "#to_game_state" do
    let!(:question) { create :question }
    let(:room) { create :room }
    let(:host) { room.host }
    let!(:user2) { create :user, room: room }
    let!(:user3) { create :user, room: room }
    let(:users) { [host, user2, user3] }

    before do
      subject.reload
      subject.set_status
    end

    context "before game has started" do
      it "returns the room's current game state" do
        state = subject.to_game_state

        expect(state["id"]).to eq(room.id)
        expect(state["name"]).to eq(room.name)
        expect(state["password"]).to eq(room.password)
        expect(state["host_id"]).to eq(room.host_id)
        expect(state["round_count"]).to eq(room.round_count)
        expect(state["round_number"]).to eq(room.round_number)
        expect(state["status"]).to eq(room.status)

        expect(state["users"].pluck("id")).to include(*users.pluck(:id))
        expect(state["users"].pluck("name")).to include(*users.pluck(:name))
        expect(state["users"].pluck("ready_for_next_round")).to include(*users.pluck(:ready_for_next_round))

        expect(state["current_round"]).to be_nil
      end
    end

    context "when game is in progress" do
      let(:room) {
        room = create :room
        room.start_game!
        room
      }
      let(:round) { room.current_round }
      let!(:answers) { users.map { |user| create(:answer, user: user, round: round) }}
      let!(:votes) { answers.map { |answer| create :vote, user: answer.user, answer: answer }}

      it "returns the room's current game state" do
        state = subject.to_game_state

        expect(state["id"]).to eq(room.id)
        expect(state["name"]).to eq(room.name)
        expect(state["password"]).to eq(room.password)
        expect(state["host_id"]).to eq(room.host_id)
        expect(state["round_count"]).to eq(room.round_count)
        expect(state["status"]).to eq(room.status)

        expect(state["users"].pluck("id")).to include(*users.pluck(:id))
        expect(state["users"].pluck("name")).to include(*users.pluck(:name))
        expect(state["users"].pluck("ready_for_next_round")).to include(*users.pluck(:ready_for_next_round))

        expect(state["current_round"]["id"]).to eq(round.id)
        expect(state["current_round"]["status"]).to eq(round.status)
        expect(state["current_round"]["question"]).to eq(round.question)
        expect(state["current_round"]["subject_id"]).to eq(round.subject_id)

        expect(state["current_round"]["answers"].pluck("id")).to include(*answers.pluck(:id))
        expect(state["current_round"]["answers"].pluck("answer")).to include(*answers.pluck(:answer))
        expect(state["current_round"]["answers"].pluck("points")).to include(*answers.map(&:points))
        expect(state["current_round"]["answers"].pluck("user_id")).to include(*answers.pluck(:user_id))
      end
    end
  end
end
