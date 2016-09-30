require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe "Get index" do
    let(:location) { create :location }

    it "renders the index template" do
      get :index
      expect(response.status).to eq(200)
    end
  end
end
