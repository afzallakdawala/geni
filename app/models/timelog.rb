class Timelog < ActiveRecord::Base
  belongs_to :user
  validate :validate_per_day
  before_save :mark_is_late_and_login_time
  
  def self.nos_of_late_users_today
    where("DATE(created_at) = ?", Date.today).count
  end

  private
  def mark_is_late_and_login_time
    t = Time.now
    self.is_late = t.strftime("%H%M").to_i > 1000
    self.login_time = t
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
