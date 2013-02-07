require 'spec_helper'

describe Award do
	it "has a valid factory" do
		FactoryGirl.create(:award).should be_valid
	end
	it "has a valid date" do
		FactoryGirl.build(:award, date: nil).should_not be_valid
	end
	it "doesn't have a date in the future" do
		FactoryGirl.build(:award, date: Date.new(2014, 4))
	end
	it "has a valid user_id" do
		FactoryGirl.build(:award, user_id: nil).should_not be_valid
	end
	it "has a description" do
		FactoryGirl.build(:award, description: nil).should_not be_valid
	end
	describe "Associations" do
		before :each do
			@award = FactoryGirl.create(:award)
		end
		context "activities" do
			it "doesn't respond to activities" do
				@award.should_not respond_to(:activities)
			end
		end
		context "analyses" do
			it "doesn't respond to analyses" do
				@award.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't espond to beta codes" do
				@award.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@award.should_not respond_to(:beta_request)
			end
		end
		context "education" do
			it "doesn't respond to education" do
				@award.should_not respond_to(:education)
			end
		end
		context "positions" do
			it "doesn't respond to positions" do
				@award.should_not respond_to(:positions)
			end
		end
		context "resumes" do
			it "doesn't respond to resumes" do
				@award.should_not respond_to(:resumes)
			end
		end
		context "skills" do
			it "responds to skills" do
				@award.should respond_to(:skills)
			end
			it "has many skills" do
				@award.should have_and_belong_to_many(:skills)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@award.should_not respond_to(:styles)
			end
		end
		context "tags" do
			it "responds to tags" do
				@award.should respond_to(:tags)
			end
			it "has many tags" do
				@award.should have_and_belong_to_many(:tags)
			end
		end
		context "users" do
			it "responds to users" do
				@award.should respond_to(:user)
			end
			it "belongs to a user" do
				@award.should belong_to(:user)
			end
		end
	end
end
