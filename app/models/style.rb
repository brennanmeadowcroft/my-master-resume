# == Schema Information
#
# Table name: styles
#
#  id          :integer         not null, primary key
#  description :string(255)
#  filename    :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Style < ActiveRecord::Base
	attr_accessible :base_style, :description, :print_filename, :screen_filename

	has_attached_file :screen_filename, 
#					  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
#					  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
					  :url => "/resume_styles/:basename.:extension",
					  :path => ":rails_root/public/resume_styles/:basename.:extension"


	has_attached_file :print_filename,
					  :url => "/resume_styles/:basename.:extension",
					  :path => ":rails_root/public/resume_styles/:basename.:extension"
	has_many :resumes

# Validations
	validates_attachment_presence :print_filename
	validates_attachment_content_type :print_filename, :content_type => ['text/css', 'application/css-stylesheet', 'text/scss']

	validates_attachment_presence :screen_filename
	validates_attachment_content_type :screen_filename, :content_type => ['text/css', 'application/css-stylesheet', 'text/scss']

	before_destroy :destroy_style


	def self.create_styles_array
		dropdown = Array.new

		styles = Style.all

		styles.each do |s|
			css = [s.description, s.id]
			dropdown << css
		end

		return dropdown
	end

	def self.set_base_style(style_id)
		base = Style.find(style_id)

		Style.update_all({:base_style => 0}, {:id => Style.all})

		base.base_style = 1
		base.save
	end

	private
    	def destroy_style
    		if Style.count <= 1 
      			errors.add(:base, 'Cannot destroy the last style!')
      			return false
      		end
    	end
end
