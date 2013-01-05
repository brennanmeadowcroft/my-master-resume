# == Schema Information
#
# Table name: activities
#
#  id           :integer         not null, primary key
#  organization :string(255)
#  position     :string(255)
#  start_date   :date
#  end_date     :date
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  user_id      :integer
#

class Activity < ActiveRecord::Base
  	attr_accessible :end_date, :organization, :position, :start_date, :user_id, :tag_ids, :skill_ids, :skill_tokens, :tag_tokens
  	attr_reader :skill_tokens, :tag_tokens

# Associations
	has_and_belongs_to_many :tags
	has_and_belongs_to_many :skills
  	belongs_to :user

# Validations
	# validates :end_date, :date => { :after => :start_date }, :if => "!end_date.nil?"
	# validates :start_date, :presence => true, :date => { :before => Time.now }
	# validates :organization, :presence => true
	# validates :user_id, :presence => true

# Callbacks
	before_save :init

# Methods
	def init
		if self.end_date.nil?
			self.end_date = self.start_date
		end
	end

	def skill_tokens=(tokens)
#        self.skill_ids = Skill.ids_from_tokens(tokens)
    end

    def tag_tokens=(tokens)
    end
end
