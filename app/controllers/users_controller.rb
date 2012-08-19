class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :admin_user, only: [:index, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html { render :layout => "public" } # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def password
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      # Check to make sure the beta code is valid
#      if BetaCodes.find_by_code(params[:beta_code]).nil?
#        flash.now[:error] = "Whoops!  We don't recognize that beta code!"
#        format.html { render action: "new" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      else 
        if @user.save
          sign_in @user
          flash[:success] = "Welcome to My Master Resume!"
          format.html { redirect_to @user }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
#      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
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
  # DELETE /users/1
  # DELETE /users/1.json
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
      # || current_user.admin?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
