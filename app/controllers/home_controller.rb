class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def get_started
  end
end
