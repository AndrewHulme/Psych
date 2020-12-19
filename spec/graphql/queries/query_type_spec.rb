require "rails_helper"

RSpec.describe Types::QueryType, type: :request do
  describe "query to get the current user" do
    subject { post "/graphql", params: { query: current_user_query }, as: :json }

    it "returns the current user" do
      subject

      user = User.last

      res = json_response["data"]["currentUser"]
      expect(res["id"]).to eq(user.id.to_s)
      expect(res["name"]).to eq(user.name)

      # do not expose visitor key via gql. unnecessary to expose this value.
      expect(res["visitorKey"]).to be_nil
    end
  end

  def current_user_query
    <<~GQL
      query {
        currentUser {
          id
          name
        }
      }
    GQL
  end
end
