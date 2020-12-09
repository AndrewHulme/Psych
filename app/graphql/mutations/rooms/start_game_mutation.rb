module Mutations
  module Rooms
    class StartGameMutation < BaseMutation
      description "Allow current user to start a game, when they are the host of a room with enough players"

      def resolve
        user = context[:current_user]
        room = user.room
        return response_error("You are not the host of this room.") unless room.host == user
        return response_error("There are not enough players to start the game.") unless room.ready_to_start?

        res = room.start_game!
        return response_failed(res) unless res == true

        # dispatch game state via action cable

        response_ok
      end
    end
  end
end
