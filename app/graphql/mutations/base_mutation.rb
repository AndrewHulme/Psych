module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    field :status, String, null: false
    field :errors, [String], null: false

    private

    def response_ok(opt = {})
      { status: "ok", errors: [] }.merge(opt)
    end

    def response_failed(object)
      { status: "failed", errors: object.errors.full_messages }
    end

    def response_errors(errors_hash)
      { status: "failed" }.merge(errors_hash)
    end
  end
end
