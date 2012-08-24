class PositionsController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@positions = current_user.positions.order("start_date DESC")

		respond_to do |format|
			format.html
			format.json { render json: @positions }
		end
	end

	def show
		@position = Position.build_position_by_position_id(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @position }
		end
	end

	def new
		@position = Position.new

		respond_to do |format|
			format.html
			format.json { render json: @position }
		end
	end

	def create
		@position = current_user.positions.new(params[:position])

		respond_to do |format|
			if @position.save
				flash[:success] = "Position was successfully created!"
				format.html { redirect_to master_resumes_url }
				format.json { render json: @position, status: :created, location: @position }
			else 
				flash[:error] = "There was an error saving your Position"
				format.html { render action: "new" }
				format.json { render json: @position, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@position = Position.find(params[:id])
	end

	def update
		@position = Position.find(params[:id])

		respond_to do |format|
			if @position.update_attributes(params[:position])
				flash[:success] = "Position was successfully created!"
				if params[:add]
					format.html { redirect_to new_experience_path({:pos => @position.id }) }
					format.json { head :no_content }
				else 
					format.html { redirect_to master_resumes_url }
					format.json { head :no_content }
				end
			else
				format.html { render action: "edit" }
				format.json { render json: @position.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@position = Position.find(params[:id])
		@position.destroy
		
		respond_to do |format|
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end
