module Mutations
  module Rounds
    class SubmitAnswerMutation < BaseMutation
      description "Allow current user to submit an answer for the current round"

      argument :answer, String, required: true

      def resolve(answer:)
        return response_error("Answer is invalid.") if answer.blank?

        user = context[:current_user]
        round = user.current_round

        answer = Answer.create(answer: answer, user: user, round: round)
        return response_failed(answer) if answer.errors.any?

        round.set_status
        response_ok
      end
    end
  end
end
