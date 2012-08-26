module ApplicationHelper
	def display_date(date_object, format = nil)
		if date_object.nil?
			return ""
		else 
			if format.nil?
				date_format = "%m/%Y"
			else
				date_format = format
			end
			return date_object.strftime(date_format)
		end
	end
end
