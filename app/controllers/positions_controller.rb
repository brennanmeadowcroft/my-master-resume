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
		respond_to do |format|
			format.html { redirect_to master_resumes_url }
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

	def linkedin
		@user = User.find(current_user)

		client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")

		if @user.linkedin_atoken.nil?
			flash[:error] = "It does not appear you have connected your LinkedIn account"
			redirect_to(@user)
		elsif client.authorize_from_access(@user.linkedin_atoken, @user.linkedin_secret)
			linkedin = client.profile(:fields => %w(positions))

			@positions = linkedin.positions.all

			@current = current_user.positions.all

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

		user = User.find(current_user)
		client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")
		client.authorize_from_access(user.linkedin_atoken, user.linkedin_secret)
		linkedin = client.profile(:fields => %w(positions))

		params[:import].each do |position|
			linkedin.positions.all.each do |item|
				if position.to_i == item.id    
					if item.startDate.nil?
						start_date = Date.today.to_s
					else 
						start_date = "#{item.startDate.month}/1/#{item.startDate.year}"
					end

					if item.endDate.nil?
						end_date = Date.today.to_s
					else 
						end_date = "#{item.endDate.month}/1/#{item.endDate.year}"
					end

					# For some reason, the position grabs experiences from another position 
					# if it is created using current_user.positions.create().  If I just use 
					# create() and add :user_id, it works fine.
					new_position = Position.create(
						:user_id => user.id,
						:title => item.title,
						:company => item.company.name,
						:start_date => start_date,
						:end_date => end_date
					)

					if new_position.save!
						error += 0
					else 
						error += 1
					end
				end
			end
		end

		if error = 0
			flash[:success] = "Positions were imported successfully"
			redirect_to(current_user)
		else
			flash[:error] = "Your positions may not have fully loaded"
			respond_to do |format|
				format.html { render action: "linkedin" }
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
