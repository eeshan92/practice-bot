class ReportController < ApplicationController
  skip_before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    @players = Player.all.
                      filter(params.slice(:full_name, :gender)).
                      order(sort_column + " " + sort_direction).
                      paginate(:page => params[:page])

    @attendances = Attendance.includes(:practice).
                      select { |att| att.practice.after? (params[:after] || Date.today.beginning_of_year) }.
                      group_by { |att| att[:player_id].to_s }
  end

  private
    def sort_column
      Player.column_names.include?(params[:sort]) ? params[:sort] : "gender"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
