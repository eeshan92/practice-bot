class Api::V1::LocationsController < Api::V1::BaseController
  before_action :set_location, only: [:show, :update, :destroy]

  def index
    @locations = Location.filter(params.slice(:latitude, :longitude, :address, :location_name))
    render json: @locations.to_json, status: :ok
  end

  def show
    render json: @location.to_json, status: :ok
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      render json: @location.to_json, status: :ok
    else
      render json: { errors: @location.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @location.update(location_params)
      render json: { id: @location.id }, status: :ok
    else
      render json: { errors: @location.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { deleted: @location.destroy.destroyed? }
  end

  private
    def set_location
      @location = Location.find(params[:id])
      rescue Exception
        render json: { error: "Resource Not Found" }, status: :not_found
    end

    def location_params
      params.require(:location).permit(:latitude, :longitude, :address, :name)
    end
end
