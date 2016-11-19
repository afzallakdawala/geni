class Timelog < ActiveRecord::Base
  belongs_to :user
  before_save :mark_is_late

  private
  def mark_is_late
    #self.is_late = 
  end

end
