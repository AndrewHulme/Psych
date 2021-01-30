require "rails_helper"

RSpec.describe Mutations::Users::UpdateUserNameMutation, type: :request do
  describe "#resolve" do
    let(:username) { "a" * (User::MAX_USERNAME_LENGTH) }
    let(:current_user) { create :user }
    let(:headers) { user_auth_headers(current_user) }

    subject { post "/graphql", params: { query: query }, headers: headers, as: :json }

    context "when username is valid" do
      it "set's the user's name to the given username" do
        prev_username = current_user.name

        subject

        current_user.reload
        expect(current_user.name).to eq(username)
        expect(current_user.name).to_not eq(prev_username)

        res = json_response["data"]["updateUserName"]
        expect(res["user"]["id"].to_i).to eq(current_user.id)
        expect(res["user"]["name"]).to eq(username)
        expect(res["status"]).to eq("ok")
        expect(res["errors"]).to eq([])
      end
    end

    context "and username argument is too long" do
      let(:username) { "a" * (User::MAX_USERNAME_LENGTH + 1) }

      it "returns an error" do
        prev_username = current_user.name

        subject

        current_user.reload
        expect(current_user.name).to eq(prev_username)

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
