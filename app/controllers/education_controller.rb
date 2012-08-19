class EducationController < ApplicationController
  before_filter :signed_in_user
  
  def index
    @education = current_user.activities

    respond_to do |format|
      format.html
      format.json { render json: @education }
    end
  end

  def show
    @education = Education.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @education }
    end
  end

  def new
    @education = Education.new
    @tags = current_user.tags

    respond_to do |format|
      format.html
      format.json { render json: @education }
    end
  end

  def create
    @education = current_user.education.new(params[:education])
    params[:education][:tag_ids] ||= []

    respond_to do |format|
      if @education.save
        flash[:success] = "Education was successfully created!"
        format.html { redirect_to master_resumes_url }
        format.json { render json: @education, status: :created, location: @education }
      else 
        flash.now[:error] = "There was an error saving your Education"
        format.html { render action: "new" }
        format.json { render json: @education, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @education = Education.find(params[:id])
    @tags = current_user.tags
  end

  def update
    @education = Education.find(params[:id])
    params[:education][:tag_ids] ||= []

    respond_to do |format|
      if @education.update_attributes(params[:education])
        flash[:success] = "Education was successfully updated"
        format.html { redirect_to master_resumes_url }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
      end
  end

  def destroy
    @education = Education.find(params[:id])
    @education.destroy
    
    respond_to do |format|
        flash[:notice] = "Education deleted"
        format.html { redirect_to master_resumes_url }
        format.json { head :no_content }
    end
  end
end
