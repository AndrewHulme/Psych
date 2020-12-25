module Mutations
  module Rounds
    class SubmitVoteMutation < BaseMutation
      description "Allow current user to submit a vote for an answer in the current round"

      argument :answer_id, ID, required: true

      def resolve(answer_id:)
        user = context[:current_user]

        answer = Answer.find_by(id: answer_id)
        return response_error("Answer not found.") if answer.blank?

        vote = Vote.create(user: user, answer: answer)
        return response_failed(vote) if vote.errors.any?

        user.current_round.set_status
        response_ok
      end
    end
  end
end
