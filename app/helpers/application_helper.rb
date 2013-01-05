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

	def parse_tags(tag_string, model_name)
		tag_array = Array.new

		string_array = tag_string.split(',')
		string_array.map do |token|
			if token.match(/<<<(.*)>>>/)
				# Determine the correct distance to move from the right to strip the >>>
				edge = token.length-4

				if model_name = 'Skill'
					tag_array << current_user.skills.create(description: token[3..edge]).id
				else
					tag_array << current_user.tags.create(description: token[3..edge]).id
				end
			else 
				tag_array << token.to_i
			end
		end

		return tag_array
	end
end
