require "rails_helper"

RSpec.describe "API v1 locations",
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

  let!(:player) { create :player }

  let!(:location) { create :location }

  let(:location_output) do
    {
      "id" => location.id,
      "name" => location.name,
      "address" => location.address,
      "longitude" => location.longitude.to_s,
      "latitude" => location.latitude.to_s,
      "updated_at" => location.updated_at.iso8601(3),
      "created_at" => location.created_at.iso8601(3)
    }
  end

  let(:valid_payload) do
    {
      "name" => "Test",
      "address" => "1601 S De Anza Blvd, Cupertino, CA 95014"
    }
  end

  let(:invalid_payload) do
    {
      "address" => "Test"
    }
  end

  it "GET index" do
    get "/api/v1/locations/",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json.count).to eq(1)
  end

  it "Get index with params" do
    get "/api/v1/locations?address=#{location.address}",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(location_output)
  end

  it "POST create" do
    post "/api/v1/locations",
      params: valid_payload.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to be_present
  end

  it "PUT update" do
    put "/api/v1/locations/#{location.id}",
      params: { "name" => "new name" }.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to eq(location["id"])
  end

  it "DELETE destroy" do
    delete "/api/v1/locations/#{location.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(json["deleted"]) # boolean response
  end

  it "DELETE destroy (invalid request test)" do
    delete "/api/v1/locations/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end

  it "GET show" do
    get "/api/v1/locations/#{location.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(location_output)
  end

  it "GET show (invalid request test)" do
    get "/api/v1/locations/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end
end
