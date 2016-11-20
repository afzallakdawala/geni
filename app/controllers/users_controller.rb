class UsersController < ApplicationController
  before_action :init_timelog
  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, flash: {notice: 'User was successfully created.'} }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to root_url, flash: {error: @user.errors.full_messages.join(', ')}}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {}).permit(:name)
    end

    def init_timelog
      @timelog = Timelog.new
    end
end
