# == Schema Information
#
# Table name: tags
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#

class Tag < ActiveRecord::Base
 	attr_accessible :description, :user_id

    has_and_belongs_to_many :activities
    has_and_belongs_to_many :awards
    has_and_belongs_to_many :education
    has_and_belongs_to_many :experiences
    has_many :positions, :through => :experiences, :uniq => true
    has_and_belongs_to_many :skills
    has_many :resumes
    belongs_to :user

  	def build_resume_by_tag

  		pos = self.positions

  		data = Hash.new
  		 i = 0

  		pos.each do |job|
  	   data[:work] = {}
       data[:work][i] = {}
  	  	data[:work][i].store(:position, job)
  			
  	 	work = self.experiences.where("position_id = #{job.id}")

  	 	data[:work][i].store(:experience, work)

       i += 1
  		 end


      # positions = Position.build_position_by_tag_id(self.id)
      # data.store(:experience, positions)

      schoolin = self.education
      data.store(:education, schoolin)

      extracurriculars = self.activities
      data.store(:activities, extracurriculars)

      blue_ribbon = self.awards
      data.store(:awards, blue_ribbon)

      mad_skills = self.skills
      data.store(:skills, mad_skills)

  		return data
  	end

    def self.tokens(query)
      tags = where("UPPER(description) like UPPER(?)", "%#{query}%")

      if tags.empty?
        [{id: "<<<#{query}>>>", description: "New: \"#{query}\""}]
      else 
        tags
      end
  end

    def self.ids_from_tokens(tokens)
#      tokens.gsub!(/<<<(.+?)>>>/) { create!(description: $1).id }
#      tokens.split(',')
    end
end
