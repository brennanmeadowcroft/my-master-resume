class SessionsController < ApplicationController
	layout "public"

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or resumes_path
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		flash[:success] = 'Logged Out Succesfully!'
		redirect_to signin_path
	end
end
