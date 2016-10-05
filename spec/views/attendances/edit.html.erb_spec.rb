require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      :practice => nil,
      :player => nil
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do

      assert_select "input#attendance_practice_id[name=?]", "attendance[practice_id]"

      assert_select "input#attendance_player_id[name=?]", "attendance[player_id]"
    end
  end
end
