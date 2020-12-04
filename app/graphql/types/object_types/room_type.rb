module Types
  module ObjectTypes
    class RoomType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :password, String, null: false
      field :round_count, Integer, null: true
      field :status, String, null: false
      field :users, [UserType], null: false
    end
  end
end
