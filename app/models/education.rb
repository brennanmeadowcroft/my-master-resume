# == Schema Information
#
# Table name: education
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  school     :string(255)
#  city       :string(255)
#  state      :string(255)
#  degree     :string(255)
#  major      :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Education < ActiveRecord::Base
	attr_accessible :city, :degree, :end_date, :major, :school, :start_date, :state, 
					:user_id, :tag_ids

#	has_many :tags, :through => :education_tag
	has_and_belongs_to_many :tags
	belongs_to :user

# Validations
	# validates :end_date, :date => { :after => :start_date }, :if => "!end_date.nil?"
	# validates :major, :presence => true
	# validates :start_date, :presence => true, :date => { :before => Time.now }
	# validates :school, :presence => true

# Callbacks


# Methods
	def init
		if self.end_date.nil?
			self.end_date = self.start_date
		end
	end
end
