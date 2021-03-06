class Api::V1::PracticesController < Api::V1::BaseController
  before_action :set_practice, only: [:show, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @practices = Practice.filter(params.slice(:status, :created_after, :date, :after)).
                          order(sort_column + " " + sort_direction).paginate(:page => params[:page])

    render json: @practices.to_json, status: :ok
  end

  def show
    render json: @practice.to_json, status: :ok
  end

  def create
    @practice = Practice.new(practice_params)

    if @practice.save
      render json: @practice.to_json, status: :ok
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
    render json: { deleted: @practice.destroy.destroyed? }
  end

  private
    def set_practice
      @practice = Practice.find(params[:id])
      rescue Exception
        render json: { error: "Resource Not Found" }, status: :not_found
    end

    def practice_params
      params.require(:practice).permit(:location_id, :date, :start, :end, :status, :after)
    end

    def sort_column
      Practice.column_names.include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
