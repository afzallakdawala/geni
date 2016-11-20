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
  def self.avg_time(data)
    times = data.collect {|t| (t.login_time.strftime("%H").to_i * 60) + t.login_time.strftime("%M").to_i}
    hours = ((times.sum/times.length)/60)
    minutes = ((times.sum/times.length)/60.0)
    minutes = (((minutes-hours)*60)).round
    "#{hours}:#{minutes.to_s.rjust(2, '0')}"
  end

  def self.stats
    {nos_of_late_users_today: nos_of_late_users_today, avg_time: avg_time_for_all_users}
  end

  def self.avg_time_for_all_users
    avg_time(Timelog.where(login_time: Date.today.beginning_of_day..Date.today.end_of_day))
  end

  def self.chart_data(user_id = nil)
    if user_id
      data = select("count(*) as y, is_late").where(user_id: user_id).group(:is_late)
    else
      data = select("count(*) as y, is_late").group(:is_late)
    end
    format_data(data)
  end

  def self.format_data(data)
    _data = []
    data.each do |d|
      _data << {name: "On time", y: d.y} unless d.is_late
      _data << {name: "Late", y: d.y} if d.is_late
    end
    _data
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
