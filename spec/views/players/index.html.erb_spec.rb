require 'rails_helper'

RSpec.describe "players/index", type: :view do
  before(:each) do
    @players = []
    2.times { @players << create(:player) }
  end

  it "renders a list of players" do
    render
  end
end
