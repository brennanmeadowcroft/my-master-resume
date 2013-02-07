require 'spec_helper'

describe Activity do
	it "has a valid factory" do
		FactoryGirl.create(:activity).should be_valid
	end
	it "has a valid start date" do
		FactoryGirl.build(:activity, start_date: nil).should_not be_valid
	end
	it "has a start_date before or equal to the end date" do
		FactoryGirl.build(:activity, start_date: Date.new(2012, 4), end_date: Date.new(2012, 2)).should_not be_valid
	end
	it "has a valid organization" do
		FactoryGirl.build(:activity, organization: nil).should_not be_valid
	end
	it "has a valid user" do
		FactoryGirl.build(:activity, user_id: nil).should_not be_valid
	end

	describe "Associations" do
		before :each do
			@activity = FactoryGirl.create(:activity)
		end

		context "resumes" do
			it "doesn't respond to resumes" do
				@activity.should_not respond_to(:resumes)
			end
		end
		context "tags" do
			it "responds to tags" do
				@activity.should respond_to(:tags)
			end
			it "has many tags" do
				@activity.should have_and_belong_to_many(:tags)
			end
		end
		context "awards" do
			it "doesn't respond to awards" do
				@activity.should_not respond_to(:awards)
			end
		end
		context "education" do
			it "doesn't respond to education" do
				@activity.should_not respond_to(:education)
			end
		end
		context "positions" do
			it "doesn't respond to positions" do
				@activity.should_not respond_to(:positions)
			end
		end
		context "skills" do
			it "responds to skills" do
				@activity.should respond_to(:skills)
			end
			it "has many skills" do
				@activity.should have_and_belong_to_many(:skills)
			end
		end
		context "analyses" do
			it "doesn't respond to analyses" do
				@activity.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't respond to beta codes" do
				@activity.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@activity.should_not respond_to(:beta_request)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@activity.should_not respond_to(:styles)
			end
		end
	end
end

