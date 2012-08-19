class AwardsController < ApplicationController
	before_filter :signed_in_user
	
	def index
		@awards = current_user.awards

		respond_to do |format|
			format.html
			format.json { render json: @awards }
		end
	end

	def show
		@award = Award.find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @award }
		end
	end

	def new
		@award = Award.new
		@tags = current_user.tags

		respond_to do |format|
			format.html
			format.json { render json: @award }
		end
	end

	def create
		@award = current_user.award.new(params[:award])
		params[:award][:tag_ids] ||= []
		@tags = current_user.tags

		respond_to do |format|
			if @award.save
				flash[:success] = "Award was successfully created!"
				format.html { redirect_to master_resumes_url }
				format.json { render json: @award, status: :created, location: @award }
			else 
				flash.now[:error] = "There was an error saving your Award"
				format.html { render action: "new" }
				format.json { render json: @award, status: :unprocessable_entity }
			end
		end
	end

	def edit
		@award = Award.find(params[:id])
		@tags = current_user.tags
	end

	def update
		@award = Award.find(params[:id])
		params[:award][:tag_ids] ||= []

		respond_to do |format|
		  if @award.update_attributes(params[:award])
		  	flash[:success] = "Award was successfully created!"
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		  else
			format.html { render action: "edit" }
			format.json { render json: @award.errors, status: :unprocessable_entity }
		  end
		end
  	end

	def destroy
		@award = Award.find(params[:id])
		@award.destroy

		respond_to do |format|
			flash[:notice] = "Award deleted"
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end
