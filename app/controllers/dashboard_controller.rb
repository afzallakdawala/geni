class DashboardController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @no_of_late_users = Timelog.nos_of_late_users_today
    @timelogs = Timelog.joins(:user).select("*, users.name as username").paginate(:page => params[:page], :per_page => 10).order("users.name asc, login_time desc")
  end
end
