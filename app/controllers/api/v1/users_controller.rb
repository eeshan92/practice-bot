class Api::V1::UsersController < Api::V1::BaseController
  def index
  end

  def me
    render json: current_user
  end

  def show
    render json: User.find(params[:id])
  end
end
