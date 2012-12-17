# == Schema Information
#
# Table name: skills
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Skill < ActiveRecord::Base
  	attr_accessible :description, :user_id, :tag_ids

# Associations
	has_and_belongs_to_many :activities
    has_and_belongs_to_many :awards
    has_and_belongs_to_many :education
    has_and_belongs_to_many :experiences
    has_many :positions, :through => :experiences
    has_and_belongs_to_many :tags
    has_many :resumes
    belongs_to :user

# Validations
	# validates :description, :presence => true
	# validates :user_id, :presence => true
end
