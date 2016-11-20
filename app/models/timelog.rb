class Timelog < ActiveRecord::Base
  belongs_to :user
  validate :validate_per_day
  before_save :mark_is_late_and_login_time
  
  def self.nos_of_late_users_today
    where("DATE(created_at) = ?", Date.today).where(is_late: true).count
  end

  def self.user_stats(user_id)
    {avg_time: Timelog.select("time(avg(time(strftime('%s',login_time)))) as average_time").where(user_id: user_id).first.average_time}
  end
  def self.avg_time
    Timelog.select("time(avg(time(strftime('%s',login_time)))) as average_time").first.average_time
  end

  def self.stats
    {nos_of_late_users_today: nos_of_late_users_today, avg_time: avg_time}
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
