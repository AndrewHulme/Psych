module Mutations
  module Rounds
    class ReadyForNextRoundMutation < BaseMutation
      description "Allow current user state that they are ready for the next round to start"

      def resolve
        user = context[:current_user]
        round = user.current_round

        return response_error("Update failed. Waiting for remaining votes.") unless round.all_votes_submitted?

        user.update(ready_for_next_round: true)
        user.errors.any? ? response_failed(user) : response_ok
      end
    end
  end
end
