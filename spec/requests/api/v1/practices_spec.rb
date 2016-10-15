require "rails_helper"

RSpec.describe "API V1 Practices",
type: :request do
  let(:user) { create :user }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "X-User-Email" => user.email,
      "X-User-Token" => user.authentication_token
    }
  end

  let!(:location) { create :location }

  let!(:first_practice) { create(:practice, location_id: location.id) }

  let(:first_practice_output) do
    {
      "id" => first_practice.id,
      "date" => first_practice.date.iso8601,
      "start" => first_practice.start.iso8601(3),
      "end" => first_practice.end,
      "status" => "active",
      "created_at" => first_practice.created_at.iso8601(3),
      "updated_at" => first_practice.created_at.iso8601(3),
      "location_id" => first_practice.location_id
    }
  end

  it "returns all practices" do
    get "/api/v1/practices",
    headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json.count).to eq(1)
  end

  it "returns specific practices" do
    get "/api/v1/practices?status=active", headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json).to include(first_practice_output)
  end
end
