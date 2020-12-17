module Types
  class MutationType < Types::BaseObject
    field :create_room, mutation: Mutations::Rooms::CreateRoomMutation
    field :join_room, mutation: Mutations::Rooms::JoinRoomMutation
    field :start_game, mutation: Mutations::Rooms::StartGameMutation

    field :update_user_name, mutation: Mutations::Users::UpdateUserNameMutation
  end
end
