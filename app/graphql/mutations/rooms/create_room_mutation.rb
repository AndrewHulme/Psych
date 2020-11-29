module Mutations
  module Rooms
    class CreateRoomMutation < BaseMutation
      field :room, Types::ObjectTypes::RoomType, null: true

      argument :name, String, required: false
      argument :password, String, required: false

      def resolve(name: nil, password: nil)
        room = Room.create(
          name: name,
          password: password,
          host: context[:current_user]
        )

        room.persisted? ? response_ok(room: room) : response_failed(room)
      end
    end
  end
end
