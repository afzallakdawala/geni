class TimelogsController < ApplicationController
  before_action :set_timelog, only: [:show, :edit, :update, :destroy]
  before_action :find_user
  # GET /timelogs/new
  def new
    @timelog = Timelog.new
  end

  # POST /timelogs
  # POST /timelogs.json
  def create
    @timelog = @user.timelogs.build(timelog_params)
    respond_to do |format|
      if @timelog.save
        format.html { render 'landing/index', notice: 'Timelog was successfully created.' }
        format.json { render :show, status: :created, location: @timelog }
      else
        format.html { render 'landing/index', notice: "Timelog failed to created" }
        format.json { render json: @timelog.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timelog
      @timelog = Timelog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timelog_params
      params.fetch(:timelog, {}).permit(:user_id, :login_time).merge({user_id: @user_id, login_time: Time.zone.now})
    end

    def find_user
      @user = User.find_by_name(params[:username])
      return true if @user
      flash[:error] = "User Not found"
      redirect_to :back
    end
end
