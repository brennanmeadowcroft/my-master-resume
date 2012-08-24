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

		respond_to do |format|
			format.html
			format.json { render json: @activity }
		end
	end

	def create
		@activity = current_user.activities.new(params[:activity])
		params[:activity][:tag_ids] ||= []

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

	def edit
		@activity = Activity.find(params[:id])
		@tags = current_user.tags
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
