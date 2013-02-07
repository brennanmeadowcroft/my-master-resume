require 'spec_helper'

describe Award do
	it "has a valid factory" do
		FactoryGirl.create(:award).should be_valid
	end
	it "has a valid date" do
		FactoryGirl.build(:award, date: nil).should_not be_valid
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
			it "responds to activities" do
				@award.should respond_to(:activities)
			end
			it "has many activities" do
				@award.should have_many(:activities)
			end
		end
		context "analyses" do
			it "responds to analyses" do
				@award.should respond_to(:analyses)
			end
			it "has many analyses" do
				@award.should have_many(:analyses)
			end
		end
		context "awards" do
			it "responds to awards" do
				@award.should respond_to(:awards)
			end
			it "has many awards" do
				@award.should have_many(:awards)
			end
		end
		context "beta_codes" do
			it "responds to beta codes" do
				@award.should respond_to(:beta_codes)
			end
			it "belongs to a beta code" do
				@award.should belong_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@award.should_not respond_to(:beta_request)
			end
		end
		context "education" do
			it "respond to education" do
				@award.should respond_to(:education)
			end
			it "has many education" do
				@award.should have_many(:education)
			end
		end
		context "positions" do
			it "responds to positions" do
				@award.should respond_to(:positions)
			end
			it "has many positions" do
				@award.should have_many(:positions)
			end
		end
		context "resumes" do
			it "responds to resumes" do
				@award.should respond_to(:resumes)
			end
			it "has many resumes" do
				@award.should have_many(:resumes)
			end
		end
		context "skills" do
			it "responds to skills" do
				@award.should respond_to(:skills)
			end
			it "has many skills" do
				@award.should have_many(:skills)
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
				@award.should have_many(:tags)
			end
		end
		context "users" do
			it "responds to users" do
				@award.should respond_to(:users)
			end
			it "belongs to a user" do
				@award.should belong_to(:user)
			end
		end
	end
end
