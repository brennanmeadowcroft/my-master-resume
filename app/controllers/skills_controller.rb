class SkillsController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json { render json: @skills }
		end
	end

	def show
		@skill = Skill.find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @skill }
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
