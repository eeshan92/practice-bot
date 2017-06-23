class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @attendances = Attendance.includes(:player, :practice).
                              order(sort_column + " " + sort_direction).paginate(:page => params[:page])
  end

  def my_index
    @attendances = Attendance.includes(:practice, :player).order("practices.date desc").where(player: current_user.player)
  end

  def show
  end

  def new
    @attendance = Attendance.new
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        analytics_track("Created attendance")
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        analytics_track("Updated attendance")
        format.html { redirect_to :back, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendance_params
      params.require(:attendance).permit(:practice_id, :player_id, :status, :comment, :confirm)
    end

    def sort_column
      Attendance.column_names.include?(params[:sort]) ? params[:sort] : "practice_id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def analytics_track(event)
      Analytics.track(
        user_id: current_user.id,
        event: event,
        properties: {
          status: @attendance.status,
          practice_id: @attendance.practice_id,
          player_id: @attendance.player_id,
          comment: @attendance.comment,
          environment: Rails.env
        })
    end
end
