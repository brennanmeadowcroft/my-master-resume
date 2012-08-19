class StaticPagesController < ApplicationController
	layout "public"
	
	def index
	end

	def features
	end

	def about
	end

	def contact
	end

	def contact_form
    	if UserMailer.contact_form(params)
    		redirect_to contact_path, :notice => "Message sent!"
    	else 
      		flash[:error] = "There was a problem sending your message!"
      		redirect_to contact_path
    	end
	end

	def request_invite
	end

	def privacy_policy
	end

	def terms_of_service
	end
end
