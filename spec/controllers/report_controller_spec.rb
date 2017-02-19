require 'rails_helper'

RSpec.describe ReportController, type: :controller do
  let(:player) { create :player }

  let(:valid_session) { {} }

  let(:invalid_session) { nil }

  describe "GET index" do
    context "with valid session" do
      it "assigns all players as @players" do
        get :index, params: {}, session: valid_session
        expect(assigns(:players)).to eq([player])
      end
    end

    context "with valid session" do
      it "assigns all players as @players" do
        get :index, params: {}, session: invalid_session
        expect(assigns(:players)).to eq([player])
      end
    end
  end
end
