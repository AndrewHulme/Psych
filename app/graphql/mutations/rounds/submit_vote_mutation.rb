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
        vote.errors.any? ? response_failed(vote) : response_ok
      end
    end
  end
end
