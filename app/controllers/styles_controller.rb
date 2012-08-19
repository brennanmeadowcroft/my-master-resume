class StylesController < ApplicationController
	before_filter :signed_in_user

	def index
		@styles = Style.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @styles }
		end
	end

	def show
		@style = Style.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @style }
		end
	end

	def new
		@style = Style.new

		respond_to do |format|
		  format.html # new.html.erb
		  format.json { render json: @style }
		end
	end

	def edit
		@style = Style.find(params[:id])
	end

	def create
		@style = Style.new(params[:style])

		respond_to do |format|
			if @style.save
				flash[:success] = 'Style was successfully created.'
				format.html { redirect_to styles_url }
				format.json { render json: @style, status: :created, location: @style }
			else
				format.html { render action: "new" }
				format.json { render json: @style.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@style = Style.find(params[:id])

		respond_to do |format|
			if @style.update_attributes(params[:style])
				flash[:success] = 'Style was successfully updated.'
				format.html { redirect_to styles_url }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @style.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@style = Style.find(params[:id])

		base = Style.find_by_base_style(1)
		if Resume.update_all({:style_id => base.id}, {:id => Resume.find_all_by_style_id(params[:id])})
			if @style.base_style == 1 
				flash[:error] = 'Can\'t delete base style! Please choose another base before deleting.'
			elsif @style.destroy
				flash[:success] = 'Style deleted.'
			else 
				flash[:error] = 'Can\'t delete last style!'
			end
		else 
			flash[:error] = 'Unable to update resumes with base style!'
		end

		respond_to do |format|
			format.html { redirect_to styles_url }
			format.json { head :no_content }
		end
	end

	def set_base_style
		@style = Style.set_base_style(params[:id])

		respond_to do |format|
			if @style
				flash[:success] = 'Base style set'
				format.html { redirect_to styles_url }
				format.json { head :no_content }
			else 
				flash[:error] = 'There was a problem setting the base style!'
				format.html { redirect_to styles_url }
				format.json { head :no_content }
			end
		end
	end

end
