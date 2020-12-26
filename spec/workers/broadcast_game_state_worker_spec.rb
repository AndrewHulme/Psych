require "rails_helper"

RSpec.describe BroadcastGameStateWorker, type: :worker do
  let!(:question) { create :question }
  let(:room) { create :room }
  let(:host) { room.host }
  let!(:user2) { create :user, room: room }
  let!(:user3) { create :user, room: room }
  let(:users) { [host, user2, user3] }

  subject do
    BroadcastGameStateWorker.new.perform(room.id)
  end

  describe "#perform" do
    it "sends a websocket broadcast with the current game state" do
      room.reload
      expect { subject }.to have_broadcasted_to(room).from_channel(RoomChannel)
        .with(room.to_game_state)
    end
  end
end
