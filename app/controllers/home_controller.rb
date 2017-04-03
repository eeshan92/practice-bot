class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @practices = Practice.after Time.now
  end

  def get_started
  end
end
