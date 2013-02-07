require 'spec_helper'

describe Education do
	it "has a valid factory" do
		FactoryGirl.create(:education).should be_valid
	end
	it "has a valid start date" do
		FactoryGirl.build(:education, start_date: nil).should_not be_valid
	end
	it "doesn't have a future start date" do
		FactoryGirl.build(:education, start_date: Date.new(2014, 1)).should_not be_valid
	end
	it "end date cannot be before start date" do
		FactoryGirl.build(:education, start_date: Date.new(2002, 5), end_date: Date.new(2001, 9)).should_not be_valid
	end
	it "has a valid major" do
		FactoryGirl.build(:education, major: nil).should_not be_valid
	end
	it "has a valid school" do
		FactoryGirl.build(:education, school: nil).should_not be_valid
	end
	it "has a valid user_id" do
		FactoryGirl.build(:education, user_id: nil).should_not be_valid
	end
	describe "Associations" do
		before :each do
			@education = FactoryGirl.create(:education)
		end
		context "activities" do
			it "doesn't respond to activities" do
				@education.should_not respond_to(:activities)
			end
		end
		context "analyses" do
			it "doesn't respond to analyses" do
				@education.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't respond to beta codes" do
				@education.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@education.should_not respond_to(:beta_request)
			end
		end
		context "experiences" do
			it "doesn't respond to experience" do
				@education.should_not respond_to(:experiences)
			end
		end
		context "positions" do
			it "doesn't responds to positions" do
				@education.should_not respond_to(:positions)
			end
		end
		context "resumes" do
			it "doesn't responds to resumes" do
				@education.should_not respond_to(:resumes)
			end
		end
		context "skills" do
			it "responds to skills" do
				@education.should respond_to(:skills)
			end
			it "has many skills" do
				@education.should have_and_belong_to_many(:skills)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@education.should_not respond_to(:styles)
			end
		end
		context "tags" do
			it "responds to tags" do
				@education.should respond_to(:tags)
			end
			it "has many tags" do
				@education.should have_and_belong_to_many(:tags)
			end
		end
		context "users" do
			it "responds to users" do
				@education.should respond_to(:user)
			end
			it "belongs to a user" do
				@education.should belong_to(:user)
			end
		end
	end
end
