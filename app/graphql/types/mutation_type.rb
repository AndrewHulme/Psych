module Types
  class MutationType < Types::BaseObject
    field :create_room, mutation: Mutations::Rooms::CreateRoomMutation
  end
end
