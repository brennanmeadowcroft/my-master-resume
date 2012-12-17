object @map_data
attributes :id, :description, :position, :start_date, :end_date, :school, :city, :state, :degree, :major, :title
attributes :company, :if => lambda { |map_data| map_data.class.name == "Position" }
attributes :organization => :company, :if => lambda { |map_data| map_data.class.name == "Activity" }

node(:node_type) { |map_data| map_data.class.name }
node(:node_class) {}

node :experience, :if => lambda { |map_data| map_data.class.name == "Position" } do |map_data|
	map_data.experiences.by_tag(@resume.tag_id).map do |experience|
		result = {}
		result['id'] = experience.id
		result['description'] = experience.description
		result['skills'] = experience.skills
		result
	end
end

child :skills do
	attributes :id, :description
	node(:node_class) {}
end