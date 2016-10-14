class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  protect_from_forgery with: :null_session

  respond_to :json

  def index
  end

  def me
    render json: current_user
  end

  def show
    render json: User.find(params[:id])
  end
end
