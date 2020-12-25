require "rails_helper"

RSpec.describe Mutations::Rounds::ReadyForNextRoundMutation, type: :request do
  describe "#resolve" do
    let!(:question) { create :question }
    let(:room) {
      room = create :room
      room.start_game!
      room
    }
    let(:round) { room.current_round }
    let(:host) { room.host }
    let!(:user2) { create :user, room: room }
    let!(:user3) { create :user, room: room }

    let(:users) { [host, user2, user3] }
    let!(:answers) { users.map { |user| create(:answer, user: user, round: round) }}
    let!(:votes) { answers.map { |answer| create :vote, user: answer.user, answer: answer }}

    before { set_current_user(host) }

    subject { post "/graphql", params: { query: query }, as: :json }

    context "when answers in the current_round have all been voted on" do
      it "allows the user to state that they are ready to start the next round" do
        expect(host.ready_for_next_round).to be_nil

        subject

        host.reload
        expect(host.ready_for_next_round).to eq(true)

        res = json_response["data"]["readyForNextRound"]
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end
    end

    context "when answers in the current_round have not all been voted on" do
      let!(:votes) do
        non_voting_user = users.sample
        answers.map { |answer| answer.user == non_voting_user ? nil : create(:vote, user: answer.user, answer: answer) }
      end

      it "returns an error" do
        subject

        expect(host.ready_for_next_round).to be_nil

        res = json_response["data"]["readyForNextRound"]
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Update failed. Waiting for remaining votes."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        readyForNextRound {
          status
          errors
        }
      }
    GQL
  end
end
