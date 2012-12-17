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

	def self.get_map_data(user_id, tag_id=nil)
		if tag_id.nil? 
			activity_tags = ""
			activity_select = "WHERE a.user_id = #{user_id}"

			education_tags = ""
			education_select = "WHERE c.user_id = #{user_id}"

			position_tags = ""
			position_select = "WHERE e.user_id = #{user_id}"
		
		else 
			activity_tags = "INNER JOIN activities_tags AS b ON(a.id = b.activity_id)"
			activity_select = "WHERE a.user_id = #{user_id} AND b.tag_id = #{tag_id}"

			education_tags = "INNER JOIN education_tags AS d ON(c.id = d.education_id)"
			education_select = "WHERE c.user_id = #{user_id} AND d.tag_id = #{tag_id}"

			position_tags = "INNER JOIN experiences AS f ON (e.id = f.position_id) 
						INNER JOIN experiences_tags AS g ON (f.id = g.experience_id)"
			position_select = "WHERE e.user_id = #{user_id} AND g.tag_id = #{tag_id}"

		end

		query = "SELECT id, organization, title, city, state, degree, major, start_date, end_date, type
				FROM (
					SELECT a.id, 
					   a.organization, 
					   a.position AS title, 
					   NULL AS city, 
					   NULL AS state, 
					   NULL AS degree,
					   NULL AS major, 
					   a.start_date, 
					   a.end_date,
					   'ASSOCIATION' AS type
				FROM Activities AS a
				#{activity_tags}
				#{activity_select}
				UNION ALL
					SELECT c.id, 
						   c.school AS organization, 
						   NULL AS title,
						   c.city, 
						   c.state, 
						   c.degree, 
						   c.major, 
						   c.start_date, 
						   c.end_date,
						   'SCHOOL' AS type
					FROM Education AS c
					#{education_tags}
					#{education_select}
				UNION ALL 
					SELECT e.id, 
						   e.company AS organization, 
						   e.title, 
						   e.city, 
						   e.state, 
					   	   NULL AS degree,
						   NULL AS major, 
						   e.start_date, 
						   e.end_date,
						   'JOB' AS type
					FROM Positions AS e
					#{position_tags}
					#{position_select}
			) AS z
			ORDER BY start_date ASC"

		data = ActiveRecord::Base.connection.execute(query)

		
	end
end
