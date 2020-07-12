require 'time'

class String

  def to_time
    Time.parse(self)
  end

end

class Time

  def date
    strftime("%b %-d, %Y")
  end

  def week_day
    strftime("%a").downcase.to_sym
  end

  def time
    strftime("%l:%M %P")
  end

  def date_time
    "#{date} #{time}"
  end

  def output
    strftime("%a %b %d %H:%M:%S %Y")
  end

  def tomorrow
    self + 86400
  end

end

class BusinessHours

  DAYS_IN_A_WEEK = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]

  def initialize(start_time, end_time)
    @business_hours = {}
    DAYS_IN_A_WEEK.each do |day|
      @business_hours[day] = {
        start_time: start_time,
        end_time: end_time
      }
    end
  end

  def update(day_or_date, start_time, end_time)
    @business_hours[day_or_date] = {
      start_time: start_time,
      end_time: end_time
    }
  end

  def closed(*days_or_dates)
    days_or_dates.each do |day_or_date|
      @business_hours[day_or_date] = {
        start_time: "00:00 AM",
        end_time: "00:00 AM"
      }
    end
    puts @business_hours
  end

  def calculate_deadline(interval, starting_time)
    today = starting_time.to_time
    date_today = today.date
    time_now = today.time

    business_hours_today = @business_hours[date_today] || @business_hours[today.week_day]
    start_time = business_hours_today[:start_time]
    end_time = business_hours_today[:end_time]

    if time_now.to_time < end_time.to_time
      time_now = start_time if time_now.to_time < start_time.to_time
      time_left_today = end_time.to_time - time_now.to_time
      if time_left_today > interval
        return "#{date_today} #{time_now}".to_time + interval
      else
        interval -= time_left_today
      end
    end
    calculate_deadline(interval, date_today.to_time.tomorrow.date_time)
  end

end

# given test case
hours = BusinessHours.new("9:00 AM", "3:00 PM")
hours.update :fri, "10:00 AM", "5:00 PM"
hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"
hours.closed :sun, :wed, "Dec 25, 2010"

puts hours.calculate_deadline(2 * 60 * 60, "Jun 7, 2010 9:10 AM").output
puts hours.calculate_deadline(15 * 60, "Jun 8, 2010 2:48 PM").output
puts hours.calculate_deadline(7 * 60 * 60, "Dec 24, 2010 6:45 AM").output
