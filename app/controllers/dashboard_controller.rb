class DashboardController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @stats = Timelog.stats
    @timelogs = Timelog.joins(:user).select("*, users.name as username").paginate(:page => params[:page], :per_page => 10).order("users.name asc, login_time desc")
  end
end
