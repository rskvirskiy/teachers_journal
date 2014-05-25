class TimesheetsAutoGenerateService
	def initialize(academic_hours_pro_lecture, minutes_number_pro_academic_hour, start_date, finish_date, default_type,
			current_week_type, delete_another, user)

		@lecture_latency   = (academic_hours_pro_lecture.to_f * minutes_number_pro_academic_hour.to_f) / 60
		@start_date        = Date.parse(start_date)
		@finish_date       = Date.parse(finish_date)
		@default_type      = default_type
		@delete_another    = delete_another
		@user              = user
		@current_week_type = current_week_type
	end

	def perform
		auto_generate
	end

	private

	def auto_generate
		destroy_all_old_records if @delete_another

		generate_timesheets
	end

	def destroy_all_old_records
		@user.timesheets.destroy_all if @user
	end

	def generate_timesheets
		week_type = @current_week_type || get_first_type
		dont_inc  = @start_date.wday == 0

		(@start_date..@finish_date).to_a.each do |date|
			if date.wday == 0
				if dont_inc
					dont_inc = false
				else
					week_type = next_week_type week_type
				end
			end

			create_day_timesheet(get_schedules(week_type, date.wday), date)
		end
	end

	def create_day_timesheet(schedules, date)
		return unless schedules

		schedules.order(:number).each do |schedule|
			@user.timesheets.create do |timesheet|
				timesheet.date         = date
				timesheet.group        = schedule.group.name if schedule.group
				timesheet.subject      = schedule.subject.name if schedule.subject
				timesheet.type_of_work = @default_type
				timesheet.hours        = @lecture_latency
			end
		end
	end

	def next_week_type(type)
		week_type_chain[type]
	end

	def week_type_chain
		@week_type_chain ||= generate_week_type_chain
	end

	def generate_week_type_chain
		types_array = @user.schedules.pluck(:type_of_week).uniq
		last_index = types_array.count - 1

		types_array.each_with_index.inject({}) do |chain, element_and_index|
			type, index = element_and_index

			if index == last_index
				chain[type] = types_array[0]
			else
				chain[type] = types_array[index + 1]
			end

			chain
		end
	end

	def get_first_type
		week_type_chain.keys.first
	end

	def get_schedules(week_type, wday)
		schedules_hash[week_type + wday.to_s] ||= @user.schedules.where(type_of_week: week_type, day_of_week: wday)
	end

	def schedules_hash
		@schedules ||= {}
	end
end