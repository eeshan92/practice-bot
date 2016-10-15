require "rails_helper"

RSpec.describe "API V1 Users", type: :request do
  let(:user) { create :user }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "X-User-Email" => user.email,
      "X-User-Token" => user.authentication_token
    }
  end

  it "returns current user information" do
    get "/api/v1/users/me", headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(response.body).to eq(user.to_json)
  end

  it "returns specific user information" do
    get "/api/v1/users/#{user.id}", headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(response.body).to eq(user.to_json)
  end
end
