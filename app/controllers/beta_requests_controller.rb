class BetaRequestsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :admin_user

  # GET /beta_requests
  # GET /beta_requests.json
  def index
    @beta_requests = BetaRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beta_requests }
    end
  end

  # GET /beta_requests/new
  # GET /beta_requests/new.json
  def new
    @beta_request = BetaRequest.new

    respond_to do |format|
      format.html { render :layout => "public" }# new.html.erb
      format.json { render json: @beta_request }
    end
  end

  # GET /beta_requests/1/edit
  def edit
    @beta_request = BetaRequest.find(params[:id])
    @beta_codes = BetaCode.create_codes_array  
  end

  # POST /beta_requests
  # POST /beta_requests.json
  def create
    @beta_request = BetaRequest.new(params[:beta_request])

    respond_to do |format|
      if @beta_request.save
        UserMailer.welcome_email(@beta_request).deliver

        format.html { redirect_to request_invite_url, notice: 'Beta request was successfully created.' }
        format.json { render json: @beta_request, status: :created, location: @beta_request }
      else
        format.html { render action: "new" }
        format.json { render json: @beta_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beta_requests/1
  # PUT /beta_requests/1.json
  def update
    @beta_request = BetaRequest.find(params[:id])
    beta_code = BetaCode.find(params[:beta_request][:beta_code_id]).code
    email = BetaRequest.find(params[:id]).email

    respond_to do |format|
      if @beta_request.update_attributes(params[:beta_request])
        BetaRequestMailer.approve_request_email(email, beta_code).deliver

        format.html { redirect_to beta_requests_url, notice: 'Beta request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beta_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_requests/1
  # DELETE /beta_requests/1.json
  def destroy
    @beta_request = BetaRequest.find(params[:id])
    @beta_request.destroy

    respond_to do |format|
      format.html { redirect_to beta_requests_url }
      format.json { head :no_content }
    end
  end
end
