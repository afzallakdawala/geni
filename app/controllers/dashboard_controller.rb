class DashboardController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @timelogs = Timelog.all
  end
end
