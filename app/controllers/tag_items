class TagItemController < ApplicationController
	def new
		@tags = current_user.tags.all

		respond_to do |format|
			format.html { render action: "new" }
			format.json { head :no_content }
		end
	end

	def create
		model = params[:model]

		model.find(id).tags << Tag.find(params[:tag])

		respond_to do |format|
			format.html { redirect_to master_resumes_url }
			format.json { head :no_content }
		end
	end
end