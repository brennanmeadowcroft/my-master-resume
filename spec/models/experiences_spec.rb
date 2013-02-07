require 'spec_helper'

describe Experience do
	it "has a valid factory" do
		FactoryGirl.create(:experience).should be_valid
	end
	it "has a valid description" do
		FactoryGirl.build(:experience, description: nil).should_not be_valid
	end
	it "has a valid position_id" do
		FactoryGirl.build(:experience, position_id: nil).should_not be_valid
	end

	describe "Associations" do
		before :each do
			@experience = FactoryGirl.create(:experience)
		end
		context "activities" do
			it "doesn't respond to activities" do
				@experience.should_not respond_to(:activities)
			end
		end
		context "analyses" do
			it "doesn't responds to analyses" do
				@experience.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't respond to beta codes" do
				@experience.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@experience.should_not respond_to(:beta_request)
			end
		end
		context "education" do
			it "doesn't respond to education" do
				@experience.should_not respond_to(:education)
			end
		end
		context "positions" do
			it "responds to positions" do
				@experience.should respond_to(:position)
			end
			it "has many positions" do
				@experience.should belong_to(:position)
			end
		end
		context "resumes" do
			it "doesn't respond to resumes" do
				@experience.should_not respond_to(:resumes)
			end
		end
		context "skills" do
			it "responds to skills" do
				@experience.should respond_to(:skills)
			end
			it "has many skills" do
				@experience.should have_and_belong_to_many(:skills)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@experience.should_not respond_to(:styles)
			end
		end
		context "tags" do
			it "responds to tags" do
				@experience.should respond_to(:tags)
			end
			it "has many tags" do
				@experience.should have_and_belong_to_many(:tags)
			end
		end
		context "users" do
			it "doesn't respond to users" do
				@experience.should_not respond_to(:users)
			end
		end
	end
end
