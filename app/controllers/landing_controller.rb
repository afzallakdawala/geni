class LandingController < ApplicationController
  def index
    @timelog = Timelog.new
  end
end
