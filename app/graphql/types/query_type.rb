module Types
  class QueryType < Types::BaseObject
    field :current_user, Types::ObjectTypes::UserType, null: false do
      description "Get current user information."
    end

    def current_user
      context[:current_user]
    end
  end
end
