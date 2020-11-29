module Types
  module ObjectTypes
    class RoomType < Types::BaseObject
      field :id, ID, null: true
      field :name, String, null: false
      field :password, String, null: false
      field :round_count, Integer, null: true
      field :status, String, null: false
    end
  end
end
