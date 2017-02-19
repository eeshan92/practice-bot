require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe "Get index" do
    let(:valid_session) { skip("add valid session creds") }

    it "assigns all locations as @locations" do
      location = create(:location)
      get :index, params: {}, session: valid_session
      expect(assigns(:locations)).to eq([location])
    end
  end
end
