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
        answer.errors.any? ? response_failed(answer) : response_ok
      end
    end
  end
end
