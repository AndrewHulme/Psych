require "rails_helper"

RSpec.describe Mutations::Users::UpdateUserNameMutation, type: :request do
  describe "#resolve" do
    let(:username) { "a" * (User::MAX_USERNAME_LENGTH) }

    subject { post "/graphql", params: { query: query }, as: :json }

    context "when username is valid" do
      it "set's the user's name to the given username" do
        user = create_user_session

        expect(user.name).to eq("Player")

        subject

        user.reload
        expect(user.name).to eq(username)

        res = json_response["data"]["updateUserName"]
        expect(res["user"]["id"].to_i).to eq(user.id)
        expect(res["user"]["name"]).to eq(username)
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end
    end

    context "and username argument is too long" do
      let(:username) { "a" * (User::MAX_USERNAME_LENGTH + 1) }

      it "returns an error" do
        user = create_user_session

        subject

        user.reload
        expect(user.name).to eq("Player")

        res = json_response["data"]["updateUserName"]
        expect(res["user"]).to be_nil
        expect(res["status"]).to eq("failed")
        expect(res["errors"]).to eq(["Name is too long (maximum is 30 characters)"])
      end
    end
  end

  def query
    <<~GQL
      mutation {
        updateUserName(
          name: "#{username}"
        ) {
          user {
            id
            name
          }
          status
          errors
        }
      }
    GQL
  end
end