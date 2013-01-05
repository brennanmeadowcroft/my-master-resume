# == Schema Information
#
# Table name: experiences
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  position_id :integer
#  description :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Experience < ActiveRecord::Base
  	attr_accessible :description, :position_id, :tag_ids, :skill_ids, :skill_tokens, :tag_tokens
    attr_reader :skill_tokens, :tag_tokens

# Associations
#	has_and_belongs_to_many :tags
  	belongs_to :position

  	has_and_belongs_to_many :tags
  	has_and_belongs_to_many :skills

# Validations
	validates :description, :presence => true
	validates :position_id, :presence => true

# scope :by_tag, lambda do |tag|
#    	joins(:experiences_tags).where('experiences_tags.tag_id = ?', tag) unless tag.nil?
#  	end

	def self.by_tag(tag_id)
		joins(:tags).where("tag_id = #{tag_id}")
	end


  def skill_tokens=(tokens)
#   self.skill_ids = Skill.ids_from_tokens(tokens)
  end

  def tag_tokens=(tokens)
  end
end
