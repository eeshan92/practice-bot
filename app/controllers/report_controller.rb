class ReportController < ApplicationController
  skip_before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  before_action :set_after

  def index
    @players = Player.all.
                      includes(:attendances).
                      filter(params.slice(:full_name, :gender)).
                      order(sort_column + " " + sort_direction).
                      paginate(:page => params[:page])
  end

  private
    def sort_column
      Player.column_names.include?(params[:sort]) ? params[:sort] : "gender"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_after
      @after = (params[:after] || Time.now.beginning_of_year)
    end
end
