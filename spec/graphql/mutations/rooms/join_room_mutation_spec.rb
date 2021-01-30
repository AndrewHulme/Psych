require "rails_helper"

RSpec.describe Mutations::Rooms::JoinRoomMutation, type: :request do
  describe "#resolve" do
    let!(:room) { create :room }
    let(:host) { room.host }
    let(:password) { room.password }
    let(:current_user) { create :user }
    let(:headers) { user_auth_headers(current_user) }

    subject { post "/graphql", params: { query: query }, headers: headers, as: :json }

    context "when password is valid" do
      it "adds the current_user to the room" do
        subject

        res = json_response["data"]["joinRoom"]
        expect(res["room"]["id"].to_i).to eq(room.id)
        expect(res["room"]["status"]).to eq("awaiting_players")
        expect(res["room"]["users"].count).to eq(2)
        expect(res["room"]["users"][0]["id"].to_i).to eq(current_user.id)
        expect(res["room"]["users"][1]["id"].to_i).to eq(host.id)
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end

      it "enqueues a job to broadcast the updated game state" do
        subject

        expect(BroadcastGameStateWorker).to have_enqueued_sidekiq_job(room.id)
      end

      context "when room is 1 player short of being ready to start a game" do
        let!(:second_player) { create :user, room: room }

        it "adds the current_user to the room and updates the status of the room to :ready_to_start" do
          expect(room.users.count).to eq(2)

          subject

          res = json_response["data"]["joinRoom"]
          expect(res["room"]["id"].to_i).to eq(room.id)
          expect(res["room"]["status"]).to eq("ready_to_start")
          expect(res["room"]["users"].count).to eq(3)
          expect(res["room"]["users"][0]["id"].to_i).to eq(current_user.id)
          expect(res["room"]["users"][1]["id"].to_i).to eq(second_player.id)
          expect(res["room"]["users"][2]["id"].to_i).to eq(host.id)
          expect(res["status"]).to eq("ok")
          expect(res["errors"]).to eq([])
        end
      end
    end

    context "when password is invalid" do
      let(:password) { "some.invalid.room.password" }

      it "returns an error" do
        subject

        res = json_response["data"]["joinRoom"]
        expect(res["room"]).to be_nil
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Password is invalid."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        joinRoom(password: "#{password}") {
          room {
            id
            name
            password
            roundCount
            status
            users {
              id
              name
            }
          }
          status
          errors
        }
      }
    GQL
  end
end