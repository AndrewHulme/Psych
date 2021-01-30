# require 'rails_helper'

# RSpec.describe AuthController, type: :request do
#   describe "POST /visitor-key" do
#     subject { post "/visitor-key" }

#     it "returns http success" do
#       subject

#       expect(response).to have_http_status(:success)
#     end

#     it "sets cookies.visitor_key and ensures the value persists on subsequent requests" do
#       subject

#       initial_visitor_key = cookies[:visitor_key]
#       expect(cookies[:visitor_key].present?).to eq(true)

#       post "/visitor-key"

#       expect(cookies[:visitor_key].present?).to eq(true)
#       expect(cookies[:visitor_key]).to eq(initial_visitor_key)
#     end
#   end
# end
