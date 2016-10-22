require 'rails_helper'

RSpec.describe "players/edit", type: :view do
  before(:each) do
    @player = create :player
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", player_path(@player), "post" do
    end
  end
end
