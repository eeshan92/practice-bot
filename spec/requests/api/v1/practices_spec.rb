require "rails_helper"

RSpec.describe "API V1 Practices",
type: :request do
  let(:user) { create :user }

  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "Content-type" => "application/json",
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
      "status" => first_practice.status,
      "created_at" => first_practice.created_at.iso8601(3),
      "updated_at" => first_practice.created_at.iso8601(3),
      "location_id" => first_practice.location_id
    }
  end

  let(:valid_payload) do
    {
      "location_id" => location.id,
      "date" => "2016/1/18"
    }
  end

  let(:invalid_payload) do
    {
      "date" => "2016/1/18"
    }
  end

  it "GET index" do
    get "/api/v1/practices", headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json.count).to eq(1)
  end

  it "Get index with params" do
    get "/api/v1/practices?status=active", headers: headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json).to include(first_practice_output)
  end

  it "POST create" do
    post "/api/v1/practices", valid_payload.to_json, headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to be_present
  end

  it "POST create (invalid request test)" do
    post "/api/v1/practices", invalid_payload.to_json, headers

    expect(response.status).to eq(422)
    expect(response.content_type).to eq("application/json")
    expect(json["error"]["location_id"]).to include("can't be blank")
  end

  it "PUT update" do
    put "/api/v1/practices/#{first_practice.id}", { "date" => "2016/10/18" }.to_json, headers

    expect(response).to be_successful
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to eq(first_practice_output["id"])
  end

  it "DELETE destroy" do
    delete "/api/v1/practices/#{first_practice.id}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(204)
  end
end
