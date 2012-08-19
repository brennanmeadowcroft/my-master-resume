class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to signin_path, :notice => "Email sent with password reset instructions"
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => "Password reset has expired."
  	elsif @user.update_attributes(params[:user])
  		redirect_to root_url, :notice => "Password has been reset!"
  	else
  		render :edit
  	end
  end

  def admin_password_reset
    if current_user.admin?
      user = User.find(params[:id])
      user.send_password_reset if user
      redirect_to users_path, :notice => "Email sent with password reset instructions"
    else 
      flash[:error] = "You must be an admin to complete that action!"
      redirect_to users_path
    end
  end
end
