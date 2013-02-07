class Analysis < ActiveRecord::Base
	attr_accessible :user_id, :resume_id

	has_many :user_strings 
	has_and_belongs_to_many :job_descriptions
	belongs_to :user
	belongs_to :resume

	def self.map_json(tag_id)
		tag = Tag.find(tag_id)

		map = Array.new
#		map += tag.awards
		map += tag.activities
		map += tag.education
		map += tag.positions

		sorted_map = map.sort_by(&:start_date).reverse
	end
end
