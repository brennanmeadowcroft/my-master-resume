object @skills
attributes :id, :description
node do |skill| { 
	:skill_class => skill.description.downcase.gsub(' ', '_')
}
end