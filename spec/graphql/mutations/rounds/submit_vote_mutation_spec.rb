require "rails_helper"

RSpec.describe Mutations::Rounds::SubmitVoteMutation, type: :request do
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

    let!(:answer1) { create :answer, round: round, user: host }
    let!(:answer2) { create :answer, round: round, user: user2 }
    let!(:answer3) { create :answer, round: round, user: user3 }

    before { set_current_user(host) }

    subject { post "/graphql", params: { query: query }, as: :json }

    context "when answer_id is valid" do
      let!(:answer_id) { answer2.id }

      it "submits a vote for the answer" do
        subject

        expect(Vote.count).to eq(1)

        vote = Vote.last
        expect(vote.user).to eq(host)
        expect(vote.answer).to eq(answer2)

        answer2.reload
        expect(answer2.points).to eq(1)

        round.reload
        expect(round.status).to eq("all_answers_submitted")

        res = json_response["data"]["submitVote"]
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end

      it "enqueues a job to broadcast the updated game state" do
        subject

        expect(BroadcastGameStateWorker).to have_enqueued_sidekiq_job(room.id)
      end

      context "when current user votes for their own answer" do
        let!(:answer_id) { answer1.id }

        it "submits a vote for the answer" do
          subject

          expect(Vote.count).to eq(1)

          vote = Vote.last
          expect(vote.user).to eq(host)
          expect(vote.answer).to eq(answer1)

          answer1.reload
          expect(answer1.points).to eq(1)

          res = json_response["data"]["submitVote"]
          expect(res["status"]).to eq("ok")
          expect(res["errors"]).to eq([])
        end
      end

      context "when current user is the last user to submit a vote" do
        let!(:votes) { [user2, user3].each { |user| create :vote, user: user, answer: answer1 } }

        it "updates the round's status to :all_votes_submitted" do
          subject

          expect(Vote.count).to eq(3)

          round.reload
          expect(round.status).to eq("all_votes_submitted")

          res = json_response["data"]["submitVote"]
          expect(res["status"]).to eq("ok")
          expect(res["errors"]).to eq([])
        end
      end
    end

    context "when answer is invalid" do
      let!(:answer_id) { 0 }

      it "submits the answer" do
        subject

        expect(Vote.count).to eq(0)

        res = json_response["data"]["submitVote"]
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Answer not found."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        submitVote(answerId: "#{answer_id}") {
          status
          errors
        }
      }
    GQL
  end
end
