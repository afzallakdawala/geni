class DashboardController < ApplicationController
  before_action :authenticate_admin_user!
  def index
    @no_of_late_users = Timelog.nos_of_late_users_today
    @timelogs = Timelog.paginate(:page => params[:page], :per_page => 10)
  end
end
