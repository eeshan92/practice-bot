class Api::V1::PracticesController < Api::V1::BaseController
  before_action :set_practice, only: [:show, :edit, :update, :destroy]

  def index
    @practices = Practice.filter(params.slice(:status, :created_after, :date))
    render json: @practices
  end

  def create
    @practice = Practice.new(practice_params)

    if @practice.save
      render json: @practice
    else
      render json: { error: @practice.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @practice.update(practice_params)
      render json: { id: @practice.id }, status: :ok
    else
      render json: { error: @practice.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @practice.destroy
  end

  private
    def set_practice
      @practice = Practice.find(params[:id])
      rescue Exception
        render json: { error: "Resource Not Found" }, status: :not_found
    end

    def practice_params
      params.permit(:location_id, :date, :start, :end, :status)
    end
end
