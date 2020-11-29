require "rails_helper"

RSpec.describe Mutations::Rooms::CreateRoomMutation, type: :request do
  describe "#resolve" do
    let(:data) { build :room }
    let(:name) { data.name }
    let(:password) { data.password }

    subject { post "/graphql", params: { query: query }, as: :json }

    it "creates and returns a new room" do
      subject

      expect(Room.count).to eq(1)
      expect(Room.first.host).to eq(current_user)

      res = json_response["data"]["createRoom"]

      expect(res["room"]["id"].to_i).to eq(1)
      expect(res["room"]["name"]).to eq(name)
      expect(res["room"]["password"]).to eq(password)
      expect(res["room"]["status"]).to eq("awaiting_players")

      expect(res["status"]).to eq("ok")
      expect(res["errors"]).to eq([])
    end

    context "when the given password already exists for another room" do
      let(:password) { "password123" }
      let!(:another_room) { create :room, password: password }

      it "returns an error" do
        subject

        expect(Room.count).to eq(1)
        expect(Room.first).to eq(another_room)
        expect(Room.first.host).to_not eq(current_user)

        res = json_response["data"]["createRoom"]

        expect(res["room"]).to be_nil
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Password is already taken. Please choose a different password."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        createRoom(name: "#{name}" password: "#{password}") {
          room {
            id
            name
            password
            roundCount
            status
          }
          status
          errors
        }
      }
    GQL
  end
end