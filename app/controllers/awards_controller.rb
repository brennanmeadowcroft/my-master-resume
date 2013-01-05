class AwardsController < ApplicationController
	include ApplicationHelper

	before_filter :signed_in_user
	
	def index
		@awards = current_user.awards.order("date DESC")

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
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json { render json: @award }
		end
	end

	def create
		@award = current_user.award.new(params[:award])
		@award.tag_ids = parse_tags(params[:award][:tag_tokens], 'Tag')
		@award.skill_ids = parse_tags(params[:award][:skill_tokens], 'Skill')

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

	def linkedin
	    @user = User.find(current_user)

	    client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")

		if @user.linkedin_atoken.nil?
			flash[:error] = "It does not appear you have connected your LinkedIn account"
			redirect_to(@user)
		elsif client.authorize_from_access(@user.linkedin_atoken, @user.linkedin_secret)
			linkedin = client.profile(:fields => %w(honors))
#raise linkedin.to_yaml
#raise linkedin.honors.split(/[\n]/).to_yaml
			@awards = Array.new
			if !linkedin.honors.nil?
				honors = linkedin.honors.split(/[\n]/)
				regex = /([0-9]{1,2}[\-.\/])?([0-9]{1,2}[\-.\/])?([0-9]{2,4})/
				
				honors.each do |item|
					description = item.split(regex)
					@awards.push(description[0])
				end
			end
			@current = current_user.award.all

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

		params[:import].each do |honor|
			new_award = current_user.award.create(:description => honor, :date => Date.today)

			if new_award.save!
				error += 0
			else 
				error += 1
			end
		end

		if error = 0
			flash[:success] = "Awards were imported successfully"
			redirect_to(current_user)
		else
			flash[:error] = "Your awards may not have fully loaded"
			respond_to do |format|
				format.html { render action: "linkedin" }
			end
		end
	end

	def edit
		@award = Award.find(params[:id])
		@tags = current_user.tags
		@skills = current_user.skills
	end

	def update
		@award = Award.find(params[:id])
		params[:award][:tag_ids] ||= []
		params[:award][:skill_ids] ||= []

		params[:award][:tag_ids] = parse_tags(params[:award][:tag_tokens], 'Tag')
		params[:award][:skill_ids] = parse_tags(params[:award][:skill_tokens], 'Skill')

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
