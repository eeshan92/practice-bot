require 'rails_helper'

RSpec.describe "attendances/new", type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
      :practice => nil,
      :player => nil
    ))
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do

      assert_select "input#attendance_practice_id[name=?]", "attendance[practice_id]"

      assert_select "input#attendance_player_id[name=?]", "attendance[player_id]"
    end
  end
end
