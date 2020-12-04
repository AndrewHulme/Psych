module Mutations
  module Users
    class UpdateUserNameMutation < BaseMutation
      description "Updates user's name"

      field :user, Types::ObjectTypes::UserType, null: true

      argument :name, String, required: true

      def resolve(name:)
        user = context[:current_user]
        res = user.update(name: name)

        res ? response_ok(user: user) : response_failed(user)
      end
    end
  end
end
