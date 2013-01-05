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
  	attr_accessible :description, :user_id, :tag_ids, :tag_tokens
    attr_reader :tag_tokens

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

    def self.tokens(query)
        skills = where("UPPER(description) like UPPER(?)", "%#{query}%")

        if skills.empty?
            [{id: "<<<#{query}>>>", description: "New: \"#{query}\""}]
        else 
            skills
        end
    end

    def self.ids_from_tokens(tokens)
    end

    def tag_tokens=(tokens)
    end
end
