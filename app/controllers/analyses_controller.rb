class AnalysisController < ApplicationController
	before_filter :signed_in_user
	
	def show
		@analysis = Analysis.find(params[:id])

		# Get word frequency and create histogram for resume based on user string

		# Get word frequency and create histogram for job descriptions

		# Do any other analysis you can think of

		respond_to do |format|
			format.html
		end
	end

	def new
		@analysis = Analysis.new

		# Grab the resume the user wants to use from the session variable
		@resume = Resume.find(session[:resume_id])

		# Grab job descriptions based on the tag for the resume for listing on the form
		resume_tag = @resume.tag_id
		@jobs = JobDescription.find_by_job_title()

		respond_to do |format|
			format.html
		end
	end

	def create
		# Grab, create and store a string for a given resume in the database
		@resume = Resume.find(params[:resume_id])

		# If the user input a custom job title, search LinkedIn for jobs with that title and take top 30

		# Fill remaining sample with job titles chosen by the user, if necessary
		job_descriptions = JobDescription.find(params[])

		# Check if the user submitted their own job description and store if necessary

		# Grab, create and store strings for chosen job descriptions in the database

		respond_to do |format|
			if @analysis.save!
				@user = current_user
				@user.credits += -1
				@user.save!
				
				flash[:success] = "The analysis of your resume is complete!"
				format.html { redirect_to @analysis }
			else 
				flash.now[:error] = "Oh no!  We had a problem analyzing your resume!"
				format.html { render action: "new" }
			end
		end
	end

	def edit
	end

	def update
	end

	def destroy
		@analysis = Analysis.find(params[:id])
		@analysis.destroy
		
		respond_to do |format|
			flash[:notice] = "Analysis deleted"
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end

	def purchase
		# Grab the resume id from a variable in the URL and assign to session variable
		@resume = params[:resume_id]
		session[:resume_id] = @resume.id # Allows for the resume the user is purchasing analysis for to be accessible later

		@user = current_user

		if @user.credits > 0
			respond_do do |format|
				format.html { redirect_to new_analysis_url }
			end
		else	# The user does not have credits, display the purchase page
			respond_to do |format|
				format.html
			end
		end
	end

	def job_description
	end
end
