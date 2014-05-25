module TimesheetsHelper
	def custom_date_format(date)
		date.strftime('%d/%m/%Y') if date
	end

	def start_date_default
		custom_date_format Date.today
	end

	def finish_date_default
		custom_date_format(Date.today + 3.months)
	end
end