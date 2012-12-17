class MasterResume < ActiveRecord::Base
		def self.find
		master = {}

		master[:activities] = self.activities
		master[:awards] = self.awards
		master[:education] = self.education
		master[:work] = self.positions
		master[:skills] = self.skills

		return master
	end

	def self.all
		self.show(param)
	end

	def self.activities
		Activity.find_all_by_user_id(@current_user)
	end

	def self.awards
		Award.find_all_by_user_id(@current_user)
	end

	def self.education
		Education.find_all_by_user_id(@current_user)
	end

	def self.positions
		pos = Position.find_all_by_user_id(@current_user)

		data = Hash.new
		i = 0

		pos.each do |job|
		    data[i] = {}
			data[i].store(:position, job)
				
			work = Experience.where("position_id = #{job.id}")

			data[i].store(:experience, work)

		 	i += 1
		end

		return data
	end

	def self.skills
		Skill.find_all_by_user_id(@current_user)
	end
end