module ApplicationHelper
	def display_date(date_object)
		if date_object.nil?
			return ""
		else 
			return date_object.strftime("%m/%Y")
		end
	end
end
