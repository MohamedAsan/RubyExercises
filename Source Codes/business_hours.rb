require 'time'
require 'active_support'
require 'active_support/core_ext'


class BusinessHours
	def initialize(given_opening_time, given_closing_time)
		@days = [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
		@opening_times = Hash.new(given_opening_time)
		@closing_times = Hash.new(given_closing_time)
	end

	def getOpeningTime(given_day)
		return @opening_times[given_day]
	end

	def getClosingTime(given_day)
		return @closing_times[given_day]
	end

	def update(day, given_opening_time, given_closing_time)
			@days.push(day) unless @days.include?(day)
			@opening_times[day] = given_opening_time
			@closing_times[day]	= given_closing_time
	end

	def closed(*holidays)
		holidays.each do |holiday|
			update(holiday, "00:00 AM", "00:00 AM")
		end
	end

	def generateDays
		@days.each do |day|
			if day.is_a? Symbol
				puts "#{day} Symbol"
			else
				puts "#{day} String"
			end
		end
	end

	def calculate_deadline(time_interval, given_starting_time)
		starting_time = if given_starting_time.is_a? String then Time.parse(given_starting_time) else given_starting_time end
		
		starting_day = starting_time.strftime("%b %d, %Y")
		starting_day = @days[starting_time.wday] unless @days.include?(starting_day) 
		
		starts_at = Time.parse(starting_time.strftime("%H :%M %p"))
		opens_at = Time.parse(getOpeningTime(starting_day))
		closes_at = Time.parse(getClosingTime(starting_day))

		if starts_at.between?(opens_at, closes_at)
			available_interval = closes_at - starts_at
			
			if time_interval < available_interval
				puts (starting_time + time_interval).ctime
			else
				next_day = (starting_time + 1.day).beginning_of_day
				calculate_deadline(time_interval - available_interval, next_day)
			end	
		elsif starts_at < opens_at
			available_interval = closes_at - opens_at
			
			if time_interval < available_interval
				puts ((starting_time + (opens_at - starts_at)) + time_interval).ctime
			else
				next_day = (starting_time + 1.day).beginning_of_day
				calculate_deadline(time_interval - available_interval, next_day)
			end
		else
				next_day = (starting_time + 1.day).beginning_of_day
				calculate_deadline(time_interval, next_day)
		end
	end
end

#my test case
# hours = BusinessHours.new("9:00 AM", "5:00 PM")
# hours.update :fri, "10:00 AM", "4:00 PM"
# hours.update "Aug 14, 2017", "10:00 AM", "2:00 PM"	
# hours.closed :sun, :sat, "Aug 15, 2017"

# hours.calculate_deadline(11*60*60, "Aug 11, 2017 09:00 AM")

#given test case
hours = BusinessHours.new("9:00 AM", "3:00 PM")
hours.update :fri, "10:00 AM", "5:00 PM"
hours.update "Dec 24, 2010", "8:00 AM", "1:00 PM"	
hours.closed :sun, :wed, "Dec 25, 2010"

hours.calculate_deadline(2*60*60, "Jun 7, 2010 9:10 AM")
hours.calculate_deadline(15*60, "Jun 8, 2010 2:48 PM")
hours.calculate_deadline(7*60*60, "Dec 24, 2010 6:45 AM")
