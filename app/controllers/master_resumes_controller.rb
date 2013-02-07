class MasterResumesController < ApplicationController
	before_filter :signed_in_user

	def index
		@activities = current_user.activities.order("start_date DESC")
		@awards = current_user.awards.order("date DESC")
		@education = current_user.education.order("start_date DESC")
		@positions = Position.build_position_by_user_id(current_user.id)
		@skills = current_user.skills

		respond_to do |format|
			format.html
			format.json { render json: @master }
		end
	end
end