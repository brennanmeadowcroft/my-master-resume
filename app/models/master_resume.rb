class MasterResume
	extend ActiveModel::Naming
	include ActiveModel::Conversion		# Fixes to_key error
	include MasterResumesHelper

	attr_writer :current_step
	attr_writer :current_user

	def initialize(params)
		@master = params
	end

	def persisted?
		# Fixes to_key error
		false
	end

	def user=(user)
		@current_user = user
	end

	def current_step=(step)
	 	@current_step = step || steps.first
	end

	def steps
		%w[experiences education awards activities skills]
	end

	def self.next_step
		current_step = steps[steps.index(current_step)+1]
	end

	def self.previous_step
		current_step = steps[steps.index(current_step)-1]
	end

	def self.first_step?
		current_step == steps.first
	end

	def self.last_step?
		current_step == steps.last
	end

	def all_valid?
		steps.all? do |step|
			self.current_step = step
			valid?
		end
	end

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

	def to_param
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

	def save
		# GET CURRENT STEP NAME AND SAVE TO APPROPRIATE MODEL
		# UPDATE USER
	end

	def update
	end

	def show
	end

#	def validate!
#		errors_add()
#	end

#	def read_attribute_for_validation(attr)
#		send(attr)
#	end
end