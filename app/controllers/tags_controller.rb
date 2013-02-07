class TagsController < ApplicationController

	before_filter :signed_in_user
	
	def index
		@tags = current_user.tags

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @tags.tokens(params[:q]) }
		end
	end

	def show
		respond_to do |format|
			format.html { redirect_to master_resumes_url }
		end
	end

	def new
		@tag = current_user.tags.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @tag }
		end
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def create
		@tag = current_user.tags.new(params[:tag])

		respond_to do |format|
			if @tag.save
				flash[:success] = "Tag was successfully created!"
				format.html { redirect_to tags_url }
				format.json { render json: @tag, status: :created }
			else
				flash[:error] = "There was an error saving your tag!"
				format.html { render action: "new" }
				format.json { render json: @tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@tag = Tag.find(params[:id])

		respond_to do |format|
			if @tag.update_attributes(params[:tag])
				format.html { redirect_to tags_url }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @tag.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy

		respond_to do |format|
			format.html { redirect_to tags_url }
			format.json { head :no_content }
		end
	end
end
