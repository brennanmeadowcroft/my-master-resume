class EducationController < ApplicationController
  include ApplicationHelper
  
  before_filter :signed_in_user
  
  def index
    @education = current_user.education.order("start_date DESC")

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
    @skills = current_user.skills

    respond_to do |format|
      format.html
      format.json { render json: @education }
    end
  end

  def create
    @education = current_user.education.new(params[:education])
    @education.tag_ids = parse_tags(params[:education][:tag_tokens], 'Tag')
    @education.skill_ids = parse_tags(params[:education][:skill_tokens], 'Skill')


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

  def linkedin
    @user = User.find(current_user)

      client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")

    if @user.linkedin_atoken.nil?
      flash[:error] = "It does not appear you have connected your LinkedIn account"
      redirect_to(@user)
    elsif client.authorize_from_access(@user.linkedin_atoken, @user.linkedin_secret)
      linkedin = client.profile(:fields => %w(educations))
#raise linkedin.educations.all.to_yaml

      @education = linkedin.educations.all

      @current = current_user.education.all

      respond_to do |format|
        format.html
      end
    else
      flash[:error] = "There was a problem authenticating your LinkedIn account.  Please retry connecting it."
      redirect_to(current_user)
    end
  end

  def import
    error = 0

    user = User.find(current_user)
    client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")
    client.authorize_from_access(user.linkedin_atoken, user.linkedin_secret)
    linkedin = client.profile(:fields => %w(educations))

    params[:import].each do |school|
      linkedin.educations.all.each do |item|
        if school.to_i == item.id    
          if item.startDate.nil?
            start_date = Date.today.to_s
          else 
            start_date = "9/1/#{item.startDate}"
          end

          if item.endDate.nil?
            end_date = Date.today.to_s
          else 
            end_date = "5/31/#{item.endDate}"
          end

          new_education = current_user.education.create(
              :school => item.schoolName,
              :major => item.fieldOfStudy,
              :degree => item.degree,
              :start_date => start_date,
              :end_date => end_date
            )

          if new_education.save!
            error += 0
          else 
            error += 1
          end
        end
      end
    end

    if error = 0
      flash[:success] = "Schools were imported successfully"
      redirect_to(current_user)
    else
      flash[:error] = "Your schools may not have fully loaded"
      respond_to do |format|
        format.html { render action: "linkedin" }
      end
    end
  end

  def edit
    @education = Education.find(params[:id])
    @tags = current_user.tags
    @skills = current_user.skills
  end

  def update
    @education = Education.find(params[:id])

    params[:education][:tag_ids] ||= []
    params[:education][:skill_ids] ||= []

    params[:education][:tag_ids] = parse_tags(params[:education][:tag_tokens], 'Tag')
    params[:education][:skill_ids] = parse_tags(params[:education][:skill_tokens], 'Skill')

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
