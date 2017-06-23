require 'csv'

class ReportController < ApplicationController
  skip_before_action :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    Analytics.page(
      user_id: current_user.id,
      category: 'Report',
      name: 'Attendance Report',
      properties: {
        environment: Rails.env
      })

    @players = Player.all.
                      filter(params.slice(:full_name, :gender)).
                      order(sort_column + " " + sort_direction).
                      paginate(:page => params[:page])

    @attendances = Attendance.includes(:practice).
                      select { |att| att.practice.after? (params[:after] || Date.today.beginning_of_year) }.
                      group_by { |att| att[:player_id].to_s }

    respond_to do |format|
      format.html
      format.csv { send_file download_file }
    end
  end

  def download_file
    since = params[:after] || Date.today.beginning_of_year

    players = Player.all
    attendances = Attendance.includes(:practice).
                    select { |att| att.practice.after? since }.
                    group_by { |att| att[:player_id].to_s }

    report = players.map do |player|
      player_att = attendances[player.id.to_s]
      {
        "name" => player.full_name.gsub(",",""),
        "gender" => player.gender,
        "percent" => player.attendance_record(player_att),
        "attended" => player_att.select { |att| ["attend", "late", "other"].include? att.status }.count,
        "total" => player_att.count,
        "comments" => player_att.pluck(:comment).select(&:presence).join(", ")
      }
    end

    path = File.join(Rails.root, "reports", "report_starting_#{since.strftime("%B")}.csv")

    File.delete(path) if File.exist?(path)

    CSV.open("./reports/report_starting_#{since.strftime("%B")}.csv", "a+") do |csv|
      csv << ["Name", "Gender", "Percent", "Attended", "Total", "Reasons"]
      report.each do |line|
        data = []
        line.each { |k,v| data << v }
        csv << data
      end
    end

    File.join(Rails.root, "reports", "report_starting_#{since.strftime("%B")}.csv")
  end

  private
    def sort_column
      Player.column_names.include?(params[:sort]) ? params[:sort] : "gender"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
