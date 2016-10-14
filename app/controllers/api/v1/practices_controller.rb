class Api::V1::PracticesController < Api::V1::BaseController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]

  def index
    @practices = Practice.filter(params.slice(:status, :created_after, :date))
    render json: @practices
  end

  private
    def set_practice
      @practice = Practice.find(params[:id])
    end

    def practice_params
      params.require(:practice).permit(:location_id, :date, :start, :end, :status)
    end
end
