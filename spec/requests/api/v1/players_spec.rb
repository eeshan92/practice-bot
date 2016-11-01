require "rails_helper"

RSpec.describe "API v1 players", type: :request do
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

  let(:first_player_output) do
    {
      "id" => player.id,
      "full_name" => player.full_name,
      "foreign_id" => player.foreign_id,
      "handle" => player.handle,
      "gender" => player.gender,
      "created_at" => player.created_at.iso8601(3),
      "updated_at" => player.created_at.iso8601(3),
      "email" => player.email,
      "phone" => player.phone,
      "NRIC" => player.NRIC
    }
  end

  let(:valid_payload) do
    {
      "full_name" => "Rachel",
      "handle" => "rachel",
      "gender" => "female"
    }
  end

  let(:invalid_payload) do
    {
      "handle" => "rachel",
      "gender" => "female"
    }
  end

  it "GET index" do
    get "/api/v1/players/",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json.count).to eq(1)
  end

  it "Get index with params" do
    get "/api/v1/players?handle=#{player.handle}",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(first_player_output)
  end

  it "POST create" do
    post "/api/v1/players",
      params: valid_payload.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to be_present
  end

  it "POST create (invalid request test)" do
    post "/api/v1/players",
      params: invalid_payload.to_json,
      headers: headers

    expect(response.status).to eq(422)
    expect(response.content_type).to eq("application/json")
    expect(json["errors"]["full_name"]).to include("can't be blank")
  end

  it "PUT update" do
    put "/api/v1/players/#{player.id}",
      params: { "handle" => "#{player.handle}+updated" }.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to eq(first_player_output["id"])
  end

  it "DELETE destroy" do
    delete "/api/v1/players/#{player.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(json["deleted"]) # boolean response
  end

  it "DELETE destroy (invalid request test)" do
    delete "/api/v1/players/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end

  it "GET show" do
    get "/api/v1/players/#{player.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(first_player_output)
  end

  it "GET show (invalid request test)" do
    get "/api/v1/players/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end
end
