class Api::V1::BaseController < ApplicationController
  acts_as_token_authentication_handler_for User

  def authenticate!
    render json: { error: '401 Unauthorized!' }, status: 401 unless current_user
  end

end
