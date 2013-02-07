require 'spec_helper'

describe Skill do
	it "has a valid factory" do
		FactoryGirl.create(:skill).should be_valid
	end
	it "has a valid user_id" do
		FactoryGirl.build(:skill, user_id: nil).should_not be_valid
	end
	it "has a description" do
		FactoryGirl.build(:skill, description: nil).should_not be_valid
	end
	describe "Associations" do
		before :each do
			@skill = FactoryGirl.create(:skill)
		end
		context "activities" do
			it "responds to activities" do
				@skill.should respond_to(:activities)
			end
			it "have and belong to many activities" do
				@skill.should have_and_belong_to_many(:activities)
			end
		end
		context "analyses" do
			it "doesn't respond to analyses" do
				@skill.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't respond to beta codes" do
				@skill.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@skill.should_not respond_to(:beta_request)
			end
		end
		context "education" do
			it "respond to education" do
				@skill.should respond_to(:education)
			end
			it "have and belong to many education" do
				@skill.should have_and_belong_to_many(:education)
			end
		end
		context "experiences" do
			it "responds to experiences" do
				@skill.should respond_to(:experiences)
			end
			it "has and belongs to many experiences" do
				@skill.should have_and_belong_to_many(:experiences)
			end
		end
		context "positions" do
			it "responds to positions through experiences" do
				@skill.should respond_to(:positions)
			end
			it "has many positions through experiences" do
				@skill.should have_many(:positions).through(:experiences)
			end
		end
		context "resumes" do
			it "responds to resumes (maybe)"
			it "has many resumes (maybe)"
		end
		context "styles" do
			it "doesn't respond to styles" do
				@skill.should_not respond_to(:styles)
			end
		end
		context "tags" do
			it "responds to tags" do
				@skill.should respond_to(:tags)
			end
			it "has many tags" do
				@skill.should have_and_belong_to_many(:tags)
			end
		end
		context "users" do
			it "responds to users" do
				@skill.should respond_to(:user)
			end
			it "belongs to a user" do
				@skill.should belong_to(:user)
			end
		end
	end
end
