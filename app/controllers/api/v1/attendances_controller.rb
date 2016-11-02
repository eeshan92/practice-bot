class Api::V1::AttendancesController < Api::V1::BaseController
  before_action :set_attendance, only: [:show, :update, :destroy]

  def index
    @attendances = Attendance.includes(:player, :practice).filter(params.slice(:practice_id, :player_id, :status))

    render json: @attendances.to_json, status: :ok
  end

  def show
    render json: @attendance.to_json, status: :ok
  end

  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      render json: @attendance.to_json, status: :ok
    else
      render json: { errors: @attendance.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @attendance.update(attendance_params)
      render json: { id: @attendance.id }, status: :ok
    else
      render json: { errors: @attendance.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { deleted: @attendance.destroy.destroyed? }
  end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
      rescue Exception
        render json: { error: "Resource Not Found" }, status: :not_found
    end

    def attendance_params
      params.require(:attendance).permit(:practice_id, :player_id, :status, :comment)
    end
end
