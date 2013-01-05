# == Schema Information
#
# Table name: awards
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  description :string(255)
#  date        :date
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Award < ActiveRecord::Base
  	attr_accessible :date, :description, :user_id, :tag_ids, :skill_ids, :skill_tokens, :tag_tokens
  	attr_reader :skill_tokens, :tag_tokens

# Associations
	has_and_belongs_to_many :tags
	has_and_belongs_to_many :skills
  	belongs_to :user

# Validations
	validates :date, :presence => true, :date => { :before => Time.now }
	validates :user_id, :presence => true
	validates :description, :presence => true

# Methods
	def skill_tokens=(tokens)
#        self.skill_ids = Skill.ids_from_tokens(tokens)
    end

    def tag_tokens=(tokens)
    end
end
