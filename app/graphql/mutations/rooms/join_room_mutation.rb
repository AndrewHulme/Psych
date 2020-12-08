module Mutations
  module Rooms
    class JoinRoomMutation < BaseMutation
      description "Allow current user to join a room (game lobby) with a password"

      field :room, Types::ObjectTypes::RoomType, null: true

      argument :password, String, required: true

      def resolve(password:)
        room = Room.find_by(password: password)
        return response_error("Password is invalid.") unless room.is_a?(Room)
        return response_error("You are already in this room.") if context[:current_user].room == room

        add_user_to_room(room)
      end

      private

      def add_user_to_room(room)
        room.users << context[:current_user]
        room.set_status
        context[:current_user].update!(room: room)

        response_ok(room: room)
      end
    end
  end
end
