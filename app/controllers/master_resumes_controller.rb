class MasterResumesController < ApplicationController
	before_filter :signed_in_user

	def index
		@activities = current_user.activities..order("start_date DESC")
		@awards = current_user.award.order("date DESC")
		@education = current_user.education.order("start_date DESC")
		@positions = Position.build_position_by_user_id(current_user.id)
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json { render json: @master }
		end
	end

	# def new
	# 	# Create the session variable for storing the form input
	# 	session[:master_params] ||= {}

	# 	@master_resume = MasterResume.new(session[:master_params])
	# 	@master_resume.user = current_user
	# 	@master_resume.current_step = session[:master_step]

	# 	respond_to do |format|
	# 		format.html # new.html.erb
	# 		format.json { render json: @master }
	# 	end
	# end

	# def edit
	# 	@master_resume = MasterResume.find(current_user)
	# end

	# def create
	# 	# If order parameters were submitted from the form, add them to the session variable
	# 	session[:master_params].deep_merge!(params[:master_resume]) if params[:master_resume]

	# 	@master_resume = MasterResume.new(session[:master_params])
	# 	@master_resume.user = current_user
	# 	@master_resume.current_step = session[:master_step]

	# 	# Check the step the user is on in the wizard and increment as necessary
	# 	if params[:back_button]
	# 		@master_resume.previous_step
	# 	elsif @master.last_step?
	# 		@master_resume.save(session[:master_params])
	# 	else 
	# 		@master_resume.next_step
	# 	end

	# 	# Save the current step and display the appropriate page or save
	# 	session[:master_step] = @order.current_step

	# 	respond_to do |format|
	# 		if @master_resume.save
	# 			session[:master_params] = session[:master_step] = nil
	# 			format.html { redirect_to @master_resume, notice: 'Your Master Resume was successfully created.' }
	# 			format.json { render json: @master_resume, status: :created, location: @master_resume }
	# 		else 
	# 			format.html { render action: "new" }
	# 			format.json { render json: @master_resume.errors, status: :unprocessable_entity }
	# 		end
	# 	end
	# end
end