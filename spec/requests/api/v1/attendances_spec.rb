require "rails_helper"

RSpec.describe "API v1 players",
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

  let!(:practice) do
    create(:practice,
           location_id: location.id)
  end

  let!(:attendance) do
    create(:attendance,
           practice_id: practice.id,
           player_id: player.id)
  end

  let(:attendance_output) do
    {
      "id" => attendance.id,
      "practice_id" => attendance.practice_id,
      "comment" => attendance.comment,
      "status" => attendance.status,
      "created_at" => attendance.created_at.iso8601(3),
      "updated_at" => attendance.updated_at.iso8601(3),
      "player_id" => attendance.player_id,
      "confirm"=>attendance.confirm,
      "player" => {
        "full_name" => player.full_name,
        "gender" => player.gender,
        "handle" => player.handle
      },
      "practice" => {
        "date" => practice.date.iso8601
      }
    }
  end

  let(:valid_payload) do
    {
      "practice_id" => practice.id,
      "player_id" => player.id,
      "status" => "attend"
    }
  end

  let(:invalid_payload) do
    {
      "practice_id" => practice.id,
      "player_id" => player.id,
      "status" => "invalid_status"
    }
  end

  it "GET index" do
    get "/api/v1/attendances/",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json.count).to eq(1)
  end

  it "Get index with params" do
    get "/api/v1/attendances?status=attend",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(attendance_output)
  end

  it "POST create" do
    post "/api/v1/attendances",
      params: valid_payload.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to be_present
  end

  it "POST create (invalid request test)" do
    expect {
      post "/api/v1/attendances",
        params: invalid_payload.to_json,
        headers: headers
    }.to raise_error "'invalid_status' is not a valid status"
  end

  it "PUT update" do
    put "/api/v1/attendances/#{attendance.id}",
      params: { "status" => "pending" }.to_json,
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json["id"]).to eq(attendance["id"])
  end

  it "DELETE destroy" do
    delete "/api/v1/attendances/#{attendance.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(json["deleted"]) # boolean response
  end

  it "DELETE destroy (invalid request test)" do
    delete "/api/v1/attendances/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end

  it "GET show" do
    get "/api/v1/attendances/#{attendance.id}",
      headers: headers

    expect(response.status).to eq(200)
    expect(response.content_type).to eq("application/json")
    expect(json).to include(attendance_output)
  end

  it "GET show (invalid request test)" do
    get "/api/v1/attendances/0",
      headers: headers

    expect(response.status).to eq(404)
    expect(json["error"]).to eq("Resource Not Found")
  end
end
