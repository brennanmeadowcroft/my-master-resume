class BetaCodesController < ApplicationController
  before_filter :signed_in_user

  def index
    @beta_codes = BetaCode.all

    respond_to do |format|
      format.html
      format.json { render json: @beta_codes }
    end
  end

  def new
    @beta_code = BetaCode.new

    respond_to do |format|
      format.html
      format.json { render json: @beta_code }
    end
  end

  def edit
    @beta_code = BetaCode.find(params[:id])
  end

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

  def destroy
    @beta_code = BetaCode.find(params[:id])
    @beta_code.destroy

    respond_to do |format|
      format.html { redirect_to beta_codes_url }
      format.json { head :no_content }
    end
  end
end
