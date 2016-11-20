class Timelog < ActiveRecord::Base
  belongs_to :user
  validate :validate_per_day
  before_save :mark_is_late
  
  private
  def mark_is_late
    self.is_late = self.login_time.strftime("%H%M").to_i <= 1000
  end
  
  def validate_per_day
    present_today = Timelog.where(user_id: self.user_id).where("DATE(created_at) = ?", Date.today).count
    if present_today <= 0
      return true
    else
      self.errors.add(:base, "You are already logged in for today")
      return false
    end 
  end

end
