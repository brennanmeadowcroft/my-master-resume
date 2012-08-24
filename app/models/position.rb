class Position < ActiveRecord::Base
  	attr_accessible :city, :company, :end_date, :start_date, :state, :title, :user_id, 
  					:experiences_attributes

# Associations
 	has_many :experiences, dependent: :destroy
 	accepts_nested_attributes_for :experiences, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
 	has_many :tags, :through => :experiences
  	belongs_to :user

# Validations
	validates :end_date, :date => { :after => :start_date }, :if => "!end_date.nil?"
	validates :company, :presence => true
	validates :start_date, :presence => true, :date => { :before => Time.now }
	validates :title, :presence => true
	validates :user_id, :presence => true

# Methods
	def init
		if self.end_date.nil?
			self.end_date = self.start_date
		end
	end

	def self.build_position_by_user_id(user)
		pos = Position.find_all_by_user_id(user).order("start_date DESC")

		data = Array.new
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

	def self.build_position_by_position_id(position_id)
		position = Position.find(position_id)

		data = Hash.new
		
		experience = position.experiences

		data[:position] = position
		data[:experiences] = experience

		return data
	end

	def self.tagged_experiences(tag_id)
		tag = Tag.find(tag_id)
		tag.experiences.find_by_position_id(self.id)
	end

	class << self
		def by_tag(tag_id)

			# work_experience = []
			# data = {}
			# position_ids = Position.find_by_sql("SELECT DISTINCT a.id 
			# 					  FROM positions AS a 
			# 					  INNER JOIN experiences AS b 
			# 					  ON(a.id = b.position_id) 
			# 					  INNER JOIN experiences_tags AS c 
			# 					  ON(b.id = c.experience_id) 
			# 					  WHERE tag_id = #{tag_id}")
			# Position.where("id IN (?)", position_ids)

			joins(:experiences => :tags).where(:tags => {:id => tag_id})

			# position_ids.each do |position|
			# 	pos = Position.find(position.id)
			# 	experiences = tag

			# 	data[:position] = pos
			# 	data[:experiences] = tag.experiences.find_by_position_id(position.id)
			# end

			# work_experience << data
		end
	end
end
