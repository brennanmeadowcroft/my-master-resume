class BetaCode < ActiveRecord::Base
  attr_accessible :code, :description

  #associations
  has_many :users
  has_many :beta_requests

  	def self.create_codes_array
		dropdown = Array.new

		codes = BetaCode.all

		codes.each do |s|
			css = [s.code, s.id]
			dropdown << css
		end

		return dropdown
	end
end
