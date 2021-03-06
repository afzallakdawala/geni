class TimelogsController < ApplicationController
  before_action :set_timelog, only: [:show, :edit, :update, :destroy]
  before_action :find_user
  # GET /timelogs/new
  def new
    @timelog ||= Timelog.new
  end

  # POST /timelogs
  # POST /timelogs.json
  def create
    @timelog = @user.timelogs.build(timelog_params)
    respond_to do |format|
      if @timelog.save
        format.html { redirect_to root_url, flash: flash_error}
        format.json { render :show, status: :created, location: @timelog }
      else
        format.html { redirect_to root_url, flash: base_error}
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
      params.fetch(:timelog, {}).permit(:user_id, :login_time).merge({user_id: @user_id})
    end

    def find_user
      @user = User.find_by_name(params[:username])
      return true if @user
      flash[:error] = "User Not found"
      redirect_to :back
    end

    def flash_error
      return {error: "Hey you are late."} if @timelog.is_late
      return {notice: "Wow you are on time."}
    end

    def base_error
      error = @timelog.errors
      return {error: error[:base].first} if error && error[:base]
    end
end
