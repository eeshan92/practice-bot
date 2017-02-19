class ReportController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @players = Player.all.
                      includes(:attendances).
                      filter(params.slice(:full_name, :gender, :from, :to)).
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
  end
