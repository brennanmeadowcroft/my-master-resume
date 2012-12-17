class ActivitiesController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@activities = current_user.activities.order("start_date DESC")

		respond_to do |format|
			format.html
			format.json { render json: @activities }
		end
	end

	def show
		@activity = Activity.find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @activity }
		end
	end

	def new
		@activity = Activity.new
		@tags = current_user.tags
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json { render json: @activity }
		end
	end

	def create
		@activity = current_user.activities.new(params[:activity])
		params[:activity][:tag_ids] ||= []
		params[:activity][:skill_ids] ||= []

		respond_to do |format|
			if @activity.save
				flash[:success] = "Activity was successfully updated!"
				format.html { redirect_to master_resumes_url }
				format.json { render json: @activity, status: :created, location: @activity }
			else 
				flash.now[:error] = "There was an error saving your activity."
				format.html { render action: "new" }
				format.json { render json: @activity, status: :unprocessable_entity }
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
			linkedin = client.profile(:fields => %w(associations))
#raise linkedin.to_yaml
#raise linkedin.honors.split(/[\n]/).to_yaml
			@activities = Array.new
			if !linkedin.associations.nil?
				activities = linkedin.associations.split(/(,)/)

				activities.each do |item|
					if item != ','
						@activities.push(item)
					end
				end

			end
			@current = current_user.activities.all

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

		params[:import].each do |activity|
			new_activity = current_user.activities.create(:organization => activity)

			if new_activity.save!
				error += 0
			else 
				error += 1
			end
		end

		if error = 0
			flash[:success] = "Activities were imported successfully"
			redirect_to(current_user)
		else
			flash[:error] = "Your activities may not have fully loaded"
			respond_to do |format|
				format.html { render action: "linkedin" }
			end
		end
	end

	def edit
		@activity = Activity.find(params[:id])
		@tags = current_user.tags
		@skills = current_user.skills
	end

	def update
		@activity = Activity.find(params[:id])
		params[:activity][:tag_ids] ||= []

		respond_to do |format|
			if @activity.update_attributes(params[:activity])
				flash[:success] = "Activity was successfully updated!"
				format.html { redirect_to master_resumes_url }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @activity.errors, status: :unprocessable_entity }
			end
    	end
	end

	def destroy
		@activity = Activity.find(params[:id])
		@activity.destroy
		
		respond_to do |format|
			flash[:notice] = "Activity deleted"
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end

	def tag
		@tags = current_user.tags.all
		@activity = Activity.find(params[:id])

		respond_to do |format|
			format.html { render action: "tag" }
			format.json { head :no_content }
		end
	end

	def create_tag
		model.find(params[:activity_id]).tags << Tag.find(params[:tag])

		respond_to do |format|
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end
