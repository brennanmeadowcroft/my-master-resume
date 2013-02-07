require 'spec_helper'

describe Position do
	it "has a valid factory" do
		FactoryGirl.create(:position).should be_valid
	end
	it "has a valid start date" do
		FactoryGirl.build(:position, start_date: nil).should_not be_valid
	end
	it "doesn't have a start date in the future" do
		FactoryGirl.build(:position, start_date: Date.new(2014, 01)).should_not be_valid
	end
	it "doesn't have an end date before the start date" do
		FactoryGirl.build(:position, start_date: Date.new(2013, 01), end_date: Date.new(2012, 11))
	end
	it "has a valid title" do
		FactoryGirl.build(:position, title: nil).should_not be_valid
	end
	it "has a valid company" do
		FactoryGirl.build(:position, company: nil).should_not be_valid
	end
	it "has a valid user_id" do
		FactoryGirl.build(:position, user_id: nil).should_not be_valid
	end
	it "sets the end date equal to start date if nil"
	it "creates a position with experiences"
	it "gets all the experiences by a tag"

	describe "Associations" do
		before :each do
			@position = FactoryGirl.create(:position)
		end
		context "activities" do
			it "doesn't respond to activities" do
				@position.should_not respond_to(:activities)
			end
		end
		context "analyses" do
			it "doesn't respond to analyses" do
				@position.should_not respond_to(:analyses)
			end
		end
		context "beta_codes" do
			it "doesn't respond to beta codes" do
				@position.should_not respond_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@position.should_not respond_to(:beta_request)
			end
		end
		context "education" do
			it "doesn't respond to education" do
				@position.should_not respond_to(:education)
			end
		end
		context "experiences" do
			it "responds to experiences" do
				@position.should respond_to(:experiences)
			end
			it "has many experiences" do
				@position.should have_many(:experiences)
			end
		end
		context "resumes" do
			it "doesn't respond to resumes" do
				@position.should_not respond_to(:resumes)
			end
		end
		context "skills" do
			it "responds to skills" do
				@position.should respond_to(:skills)
			end
			it "has many skills through experiences" do
				@position.should have_many(:skills).through(:experiences)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@position.should_not respond_to(:styles)
			end
		end
		context "tags" do
			it "responds to tags" do
				@position.should respond_to(:tags)
			end
			it "has many tags through experiences" do
				@position.should have_many(:tags).through(:experiences)
			end
		end
		context "users" do
			it "responds to users" do
				@position.should respond_to(:user)
			end
			it "belongs to a user" do
				@position.should belong_to(:user)
			end
		end
	end
end
