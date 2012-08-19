class ExperiencesController < ApplicationController
	before_filter :signed_in_user
	
	def index
	end

	def show
		@position = Position.build_position_by_position_id(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @position }
		end
	end

	def new
		pos = current_user.positions.find(params[:pos])
		@position_id = pos.id.to_i
		@experience = pos.experiences.new
		@tags = current_user.tags

		respond_to do |format|
			format.html
			format.json { render json: @experience }
		end
	end

	def create
		@position = Position.find(params[:experience][:position_id])
		@experience = @position.experiences.new(params[:experience])
		params[:experience][:tag_ids] ||= []

		respond_to do |format|
			if @experience.save
				flash[:success] = "Experience was successfully created!"
				format.html { redirect_to master_resumes_url }
				format.json { render json: @experience, status: :created, location: @experience }
			else 
				flash[:error] = "There was an error saving your experience"
				format.html { render action: "new" }
				format.json { render json: @experience, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@experience = Experience.find(params[:id])
		@position_id = @experience.position_id
		@tags = current_user.tags
	end

	def update
		position = Position.find(params[:experience][:position_id])
		@experience = position.experiences.find(params[:id])
		params[:experience][:tag_ids] ||= []

		respond_to do |format|
			if @experience.update_attributes(params[:experience])
				flash[:success] = "Experience was successfully updated!"
				format.html { redirect_to master_resumes_url }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @position.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@experience = Experience.find(params[:id])
		@experience.destroy
		
		respond_to do |format|
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end
