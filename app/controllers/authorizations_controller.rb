class AuthorizationsController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

	def create
		auth = request.env["omniauth.auth"]

		if current_user.add_linkedin_authentication(auth[:uid], auth[:credentials][:token], auth[:credentials][:secret])
			flash[:success] = "You have successfully connected your LinkedIn profile!"
		else
			flash[:success] = "There was a problem connecting your LinkedIn profile!"
		end

		respond_to do |format|
			sign_in current_user
			format.html { redirect_to(current_user) }
		end
	end
end