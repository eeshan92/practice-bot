require 'rails_helper'

RSpec.describe PracticesController, type: :controller do
  let(:player) { create :player }

  describe "POST create" do
    context "with valid attributes" do
      let(:location) { create :location }
      let(:practice) { build(:practice, location_id: location.id) }

      it "should create a new practice" do
        expect {
          practice.save
        }.to change(Practice, :count).by(1)
      end
    end
  end

  describe "PUT update" do
    context "with valid attributes" do
      let(:location) { create :location }
      let(:practice) { build :practice, status: 'cancelled', location_id: location.id }

      it "should update practice" do
        practice.save
        expect(response).to be_successful
      end
    end
  end

  describe "GET show" do
    context "with valid id" do
      let(:location) { create :location }
      let(:practice) { create :practice, status: 'cancelled', location_id: location.id }
      let(:attendee) { create :attendance, player_id: player.id, practice_id: practice.id }
      let(:valid_session) { skip("Add valid session creds") }

      it "should redirects to practice" do
        get :show, id: practice.id, session: valid_session
        puts response
        expect(response).to be_successful
        expect(assigns(:attendees)).to eq([attendee])
      end
    end
  end
end
