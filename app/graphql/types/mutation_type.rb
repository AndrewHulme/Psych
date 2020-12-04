module Types
  class MutationType < Types::BaseObject
    field :create_room, mutation: Mutations::Rooms::CreateRoomMutation

    field :update_user_name, mutation: Mutations::Users::UpdateUserNameMutation
  end
end
