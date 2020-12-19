module Types
  module ObjectTypes
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :room, Types::ObjectTypes::RoomType, null: true
    end
  end
end
