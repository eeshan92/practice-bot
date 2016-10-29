class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper DateHelper

  WillPaginate.per_page = 10

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:username, 
               :email, 
               :password, 
               :password_confirmation, 
               :remember_me, 
               :invite_code)
    end
  end
end
