require "rails_helper"

RSpec.describe Mutations::Rounds::SubmitAnswerMutation, type: :request do
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

    before { set_current_user(host) }

    subject { post "/graphql", params: { query: query }, as: :json }

    context "when answer is present" do
      let!(:answer) { "A valid answer" }

      it "submits the answer" do
        subject

        answer = Answer.last
        expect(answer.round).to eq(round)

        round.reload
        expect(round.status).to eq("submitting_answers")

        res = json_response["data"]["submitAnswer"]
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end

      it "enqueues a job to broadcast the updated game state" do
        subject

        expect(BroadcastGameStateWorker).to have_enqueued_sidekiq_job(room.id)
      end

      context "when current user is the last user to submit an answer" do
        let!(:answers) { [user2, user3].each { |user| create :answer, user: user, round: round } }

        it "updates the round's status to :all_answers_submitted" do
          subject

          round.reload
          expect(round.answers.count).to eq(3)
          expect(round.status).to eq("all_answers_submitted")

          res = json_response["data"]["submitAnswer"]
          expect(res["status"]).to eq("ok")
          expect(res["errors"]).to eq([])
        end
      end
    end

    context "when answer is blank" do
      let!(:answer) { "" }

      it "submits the answer" do
        subject

        expect(Answer.count).to eq(0)

        res = json_response["data"]["submitAnswer"]
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Answer is invalid."])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        submitAnswer(answer: "#{answer}") {
          status
          errors
        }
      }
    GQL
  end
end
