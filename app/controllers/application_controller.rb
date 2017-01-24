class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper DateHelper

  WillPaginate.per_page = 20

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

  def generate_url(url, params = {})
    uri = URI(url)
    uri.query = params.to_query
    uri.to_s
  end

  def json(response)
    JSON.parse(response.body)
  end
end
