class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @practices = Practice.after(Time.now).
                          paginate(:page => params[:page])
  end

  def get_started
  end
end
