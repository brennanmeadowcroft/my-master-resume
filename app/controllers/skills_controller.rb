class SkillsController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json
		end
	end

	def show
		@skill = Skill.find(params[:id])

		respond_to do |format|
			format.html
		end
	end

	def new
		@skill = Skill.new
		@tags = current_user.tags

		respond_to do |format|
			format.html
			format.json { render json: @skill }
		end
	end

	def create
		@skill = current_user.skills.new(params[:skill])
		params[:skill][:tag_ids] ||= []
#		@tags = current_user.tags

		respond_to do |format|
			if @skill.save
				flash[:success] = "Skill was successfully created!"
				format.html { redirect_to master_resumes_url }
				format.json { render json: @skill, status: :created, location: @skill }
			else 
				flash.now[:error] = "There was an error saving your skill."
				format.html { render action: "new" }
				format.json { render json: master_resumes_url, status: :unprocessable_entity }
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
			linkedin = client.profile(:fields => %w(skills))
			@skills = linkedin.skills.all
			@current = current_user.skills.all

			@search_array = []
			@current.each do |name|
				@search_array << name.description
			end

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

		params[:import].each do |skill|
			new_skill = current_user.skills.create(:description => skill)

			if new_skill.save!
				error += 0
			else 
				error += 1
			end
		end

		if error = 0
			flash[:success] = "Skills were imported successfully"
			redirect_to(current_user)
		else
			flash[:error] = "Your skills may not have fully loaded"
			respond_to do |format|
				format.html { render action: "linkedin" }
			end
		end
	end

	def edit
		@skill = Skill.find(params[:id])
		@tags = current_user.tags
	end

	def update
		@skill = Skill.find(params[:id])
		params[:skill][:tag_ids] ||= []
#		@tags = current_user.tags

		respond_to do |format|
			if @skill.update_attributes(params[:skill])
				flash[:success] = "Skill was successfully updated!"
				format.html { redirect_to master_resumes_url }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @skill.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@skill = Skill.find(params[:id])
		@skill.destroy
		
		respond_to do |format|
			flash[:notice] = "Skill deleted"
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end
