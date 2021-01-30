require "rails_helper"

RSpec.describe Users::SessionsController, type: :request do
  describe "POST to /users/sign_in" do
    subject { post "/users/sign_in" }

    context "when authorization token in header is present" do
      let!(:user) { create :user }
      let(:headers) { user_auth_headers(user) }

      subject { post "/users/sign_in", headers: headers, as: :json }

      it "finds the user and creates a session" do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.headers["Authorization"]).to match(/Bearer .+/)
        expect(json_response["id"]).to eq user.id
        expect(json_response["name"]).to eq user.name
      end
    end

    context "when authorization token in header is blank" do
      it { expect { subject }.to change { AllowlistedJwt.count }.by(1) }

      it "creates a new user and creates a session" do
        subject

        user = User.last

        expect(response).to have_http_status(:ok)
        expect(response.headers["Authorization"]).to match(/Bearer .+/)
        expect(json_response["id"]).to eq user.id
        expect(json_response["name"]).to eq user.name
      end
    end
  end
end
