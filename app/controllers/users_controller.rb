class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user

  def edit
  end

  def show
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user)
  end
end