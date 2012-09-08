class SitemapsController < ApplicationController
	skip_before_filter :signed_in_user
	skip_before_filter :current_user
	skip_before_filter :admin_user

	def show
		@pages = [
			{ :title => "Features", :url => "/features" },
			{ :title => "About", :url => "/about" },
			{ :title => "Contact Us", :url => "/contact" }
		]

		respond_to do |format|
			format.xml
		end
	end
end