class DashboardController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @stats = Timelog.stats
    @timelogs = Timelog.joins(:user).select("*, users.name as username").paginate(:page => params[:page], :per_page => 10).order("users.name asc, login_time desc")
    @chart_data = Timelog.chart_data
  end
  def user
    @stats = Timelog.user_stats(params[:id])
    @timelogs = Timelog.where(user_id: params[:id]).paginate(:page => params[:page], :per_page => 10)
    @user = User.find(params[:id])
    @chart_data = Timelog.chart_data(@user.id)
  end
end
