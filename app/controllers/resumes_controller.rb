class ResumesController < ApplicationController
  before_filter :signed_in_user
  
  # GET /resumes
  # GET /resumes.json
  def index
    @resumes = current_user.resumes

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @resumes }
      end
 #   end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
    @resume = Resume.find(params[:id])
    tag = Tag.find(@resume.tag_id)

    @positions = tag.positions.order("start_date DESC")
    @activities = tag.activities.order("start_date DESC")
    @awards = tag.awards.order("date DESC")
    @education = tag.education.order("start_date DESC")
    @skills = tag.skills

    @user_info = @resume.get_user_info

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @data }
    end
  end

  # GET /resumes/new
  # GET /resumes/new.json
  def new
    @resume = current_user.resumes.new
    @styles = Style.create_styles_array
    @tags = current_user.tags

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resume }
    end
  end

  # GET /resumes/1/edit
  def edit
    @resume = Resume.find(params[:id])
    @styles = Style.create_styles_array
    @tags = current_user.tags
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = current_user.resumes.new(params[:resume])

    respond_to do |format|
      if @resume.save
        flash[:success] = 'Resume was successfully created.'
        format.html { redirect_to @resume }
        format.json { render json: @resume, status: :created, location: @resume }
      else
        format.html { render action: "new" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resumes/1
  # PUT /resumes/1.json
  def update
    @resume = Resume.find(params[:id])

    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        flash[:success] = 'Resume was successfully updated.'
        format.html { redirect_to @resume }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy

    respond_to do |format|
      format.html { redirect_to resumes_url }
      format.json { head :no_content }
    end
  end

  def export
    @resume = Resume.find(params[:id])
    tag = Tag.find(@resume.tag_id)

    @positions = tag.positions.order("start_date DESC")
    @activities = tag.activities.order("start_date DESC")
    @awards = tag.awards.order("date DESC")
    @education = tag.education.order("start_date DESC")
    @skills = tag.skills


#    @data = @tag.build_resume_by_tag
    @user_info = @resume.get_user_info

        render :pdf => "resume", 
               :template => "/resumes/export.html.erb",
               :show_as_html => params[:debug].present? # renders html version if you set debug=true in URL
#               :user_style_sheet => @resume.style.screen_filename.path
#               :user_style_sheet => 'test1'
  end
end
