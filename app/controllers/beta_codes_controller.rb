class BetaCodesController < ApplicationController
  before_filter :signed_in_user

  # GET /beta_requests
  # GET /beta_requests.json
  def index
    @beta_codes = BetaCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beta_codes }
    end
  end

  # GET /beta_requests/new
  # GET /beta_requests/new.json
  def new
    @beta_code = BetaCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beta_code }
    end
  end

  # GET /beta_requests/1/edit
  def edit
    @beta_code = BetaCode.find(params[:id])
  end

  # POST /beta_requests
  # POST /beta_requests.json
  def create
    @beta_code = BetaCode.new(params[:beta_code])

    respond_to do |format|
      if @beta_code.save
        format.html { redirect_to beta_codes_url, notice: 'Beta Code was successfully created.' }
        format.json { render json: @beta_code, status: :created, location: @beta_code }
      else
        format.html { render action: "new" }
        format.json { render json: @beta_code.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @beta_code = BetaCode.find(params[:id])

    respond_to do |format|
      if @beta_code.update_attributes(params[:beta_code])
        format.html { redirect_to beta_codes_url, notice: 'Beta cdoe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beta_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_requests/1
  # DELETE /beta_requests/1.json
  def destroy
    @beta_code = BetaCode.find(params[:id])
    @beta_code.destroy

    respond_to do |format|
      format.html { redirect_to beta_codes_url }
      format.json { head :no_content }
    end
  end
end
