module Mutations
  module Rounds
    class ReadyForNextRoundMutation < BaseMutation
      description "Allow current user state that they are ready for the next round to start"

      def resolve
        user = context[:current_user]
        room = user.room
        round = user.current_round

        return response_error("Update failed. Waiting for remaining votes.") unless round.all_votes_submitted?

        user.update(ready_for_next_round: true)
        return response_failed(user) if user.errors.any?

        round.reload
        round.set_status
        room.next_round! if round.ready_for_next_round?

        room.broadcast_game_state
        response_ok
      end
    end
  end
end
