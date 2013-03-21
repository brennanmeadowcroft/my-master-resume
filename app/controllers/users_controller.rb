class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :linked_in, :import]
  before_filter :correct_user, only: [:edit, :update, :show, :linked_in, :import]
  before_filter :admin_user, only: [:index, :destroy]

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html { render :layout => "public" } # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def linkedin
    @user = User.find(params[:id])

    client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")

    if @user.linkedin_atoken.nil?
      flash[:error] = "It does not appear you have connected your LinkedIn account"
      redirect_to(@user)
    elsif client.authorize_from_access(@user.linkedin_atoken, @user.linkedin_secret)
      @profile = client.profile(:fields => %w(firstName lastName phoneNumbers mainAddress publicProfileUrl))

      respond_to do |format|
        format.html
      end
    else
      flash[:error] = "There was a problem authenticating your LinkedIn account.  Please retry connecting it."
      redirect_to(current_user)
    end
  end

  def import
    @user = User.find(params[:id])

    @user.first_name = params[:user_first_name]
    @user.last_name = params[:user_last_name]
    @user.website = params[:user_website]

    if @user.save!
      flash.now[:success] = "Your profile has been updated!"
      respond_to do |format|
        sign_in @user
        format.html { redirect_to @user }
      end
    else
      flash.now[:error] = "There was a problem updating your profile!"
      respond_to do |format|
        format.html { render action: "linkedin" }
      end
    end

  end

  def password
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    code = BetaCode.find_by_code(params[:beta_code])

    respond_to do |format|
      # Check to make sure the beta code is valid
      if code.nil?
        flash.now[:error] = "Whoops!  We don't recognize that beta code!"
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else 
        @user.beta_code_id = code.id
        if @user.save
          # Sign in the user to the application
          sign_in @user

          # Create a first tag to avoid broken, new resumes
          @user.tags.create(description: "First_Tag")

          flash[:success] = "Welcome to My Master Resume!"
          format.html { redirect_to @user }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        sign_in @user
        flash[:success] = "Your profile was successfully updated"
        format.html { redirect_to @user }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_admin
    @user = User.find(params[:id])

    if current_user.admin?
      @user.make_admin
      flash[:success] = "User has been made an admin"
    else
      flash[:error] = "You have the max privileges!"
    end

      redirect_to users_url
  end
  
  def revoke_admin
    @user = User.find(params[:id])

    unless current_user?(@user)
      @user.revoke_admin
      flash[:success] = "Admin privileges have been revoked"
    else
      flash[:error] = "User can't revoke own privileges!"
    end

    redirect_to users_url
  end

  def destroy
    @user = User.find(params[:id])
    unless current_user?(@user)
      @user.destroy
      flash[:success] = "User Destroyed."
    else 
      flash[:error] = "User can't commit suicide!"
    end

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def beta_request
    respond_to do |format|
      if UserMailer.beta_request(params[:email]).deliver
        flash[:success] = "Beta Request Received!"
        format.html { redirect_to request_invite_path }
        format.json { head :no_content }
      else
        flash[:error] = "Email not accepted"
        format.html { redirect_to request_invite_path }
        format.json { head :no_content }
      end
    end
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
