require "rails_helper"

RSpec.describe Mutations::Rooms::StartGameMutation, type: :request do
  describe "#resolve" do
    let(:room) { create :room }
    let(:host) { room.host }
    let!(:user2) { create :user, room: room }
    let!(:user3) { create :user, room: room }
    let!(:question) { create :question }

    before { set_current_user(host) }

    subject { post "/graphql", params: { query: query }, as: :json }

    context "when room has enough players and has status ready_to_start" do
      it "starts the game" do
        room.set_status

        expect(room.users.count).to eq(3)
        expect(room.status).to eq("ready_to_start")

        subject

        room.reload
        expect(room.status).to eq("game_in_progress")

        res = json_response["data"]["startGame"]
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end

      it "creates the first round" do
        room.set_status

        subject

        res = json_response["data"]["startGame"]
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])

        room.reload
        expect(room.rounds.count).to eq(1)

        round = room.rounds.first
        expect(room.current_round).to eq(round)
        expect(round.question.present?).to eq(true)
        expect([host, user2, user3]).to include(round.subject)
        expect(round.question).to match(round.subject.name)
      end
    end

    context "when the room does not have enough players" do
      let!(:user3) { create :user }

      it "returns an error" do
        room.set_status

        expect(room.users.count >= Room::MIN_PLAYER_COUNT).to eq(false)
        expect(room.status).to eq("awaiting_players")

        subject

        room.reload
        expect(room.status).to eq("awaiting_players")

        res = json_response["data"]["startGame"]
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["There are not enough players to start the game."])
      end
    end

    context "when the current_user is not the host of the room" do
      before { set_current_user(user3) }

      it "returns an error" do
        room.set_status

        expect(room.status).to eq("ready_to_start")

        subject

        room.reload
        expect(room.status).to eq("ready_to_start")

        res = json_response["data"]["startGame"]
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["You are not the host of this room."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        startGame {
          status
          errors
        }
      }
    GQL
  end
end
