class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  private

  def user_params
    params.require(:user)
  end
end