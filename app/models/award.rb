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
  	attr_accessible :date, :description, :user_id, :tag_ids

# Associations
	has_and_belongs_to_many :tags
  	belongs_to :user

# Validations
	validates :date, :presence => true, :date => { :before => Time.now }
	validates :user_id, :presence => true
	validates :description, :presence => true

# Methods
end
