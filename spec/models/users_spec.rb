require 'spec_helper'

describe User do
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end
	it "has a valid first name" do
		FactoryGirl.build(:user, first_name: nil).should_not be_valid
	end
	it "should respond to authenticate" do
		FactoryGirl.create(:user).should respond_to(:authenticate)
	end
	it "should only have two-letter states" do
		FactoryGirl.build(:user, state: "Colorado").should_not be_valid
	end
	describe "remember token" do
		it "should respond to remember token" do
			FactoryGirl.create(:user).should respond_to(:remember_token)
		end
		it "has a valid remember_token" do
			FactoryGirl.create(:user).remember_token.should_not eq(nil)
		end		
	end

	describe "has a password" do
		context "has a valid password" do
			before :each do
				@user = FactoryGirl.create(:user)
			end
			it "responds to password digest" do
				@user.should respond_to(:password_digest)
			end
			it "responds to password" do
				@user.should respond_to(:password)
			end
			it "responds to password_confirmation" do
				@user.should respond_to(:password_confirmation)
			end
		end
		context "doesn't work with a invalid password" do
			it "doesn't accept a password that is too short" do
				FactoryGirl.build(:user, password: "foo", password_confirmation: "bar").should_not be_valid
			end
			it "doesn't accept a blank password" do
				FactoryGirl.build(:user, password: "      ", password_confirmation: "      ").should_not be_valid
			end
			it "must match password_confirmation" do
				FactoryGirl.build(:user, password: "foobar", password_confirmation: "barfoo").should_not be_valid
			end
			it "doesn't accept a blank password_confirmation" do
				FactoryGirl.build(:user, password: "foobar", password_confirmation: nil).should_not be_valid
			end
		end
	end


	describe "has an email address" do
		describe "has a valid email address" do
			it "fails with invalid formats" do
				address = %w[user@foo,com user_at_foo.com example.user@foo. 
							foo@bar_baz.com foo@bar+baz.com]
				address.each do |invalid_address|
					FactoryGirl.build(:user, email: invalid_address).should_not be_valid
				end
			end

			it "works with valid formats" do
				address = %w[user@foo.COM a_US-ER@f.b.com first.last@foo.com a+b@foo.com 
							user@foo.com]

				address.each do |valid_address|
					FactoryGirl.build(:user, email: valid_address).should be_valid
				end
			end
		end

		describe "has a unique email address" do
			before :each do
				@first_user = FactoryGirl.create(:user)
			end

			it "fails when an address is already taken" do 
				invalid_address = @first_user.email.upcase
				FactoryGirl.build(:user, email: invalid_address).should_not be_valid
			end
			it "works when an address is new" do
				FactoryGirl.build(:user, email: "bar@foo.com").should be_valid
			end
		end
	end

	describe "Associations" do
		before :each do
			@user = FactoryGirl.create(:user)
		end

		context "resumes" do
			it "responds to resumes" do
				@user.should respond_to(:resumes)
			end
			it "has many resumes" do
				@user.should have_many(:resumes)
			end
		end
		context "tags" do
			it "responds to tags" do
				@user.should respond_to(:tags)
			end
			it "has many tags" do
				@user.should have_many(:tags)
			end
		end
		context "activities" do
			it "responds to activities" do
				@user.should respond_to(:activities)
			end
			it "has many activities" do
				@user.should have_many(:activities)
			end
		end
		context "awards" do
			it "responds to awards" do
				@user.should respond_to(:awards)
			end
			it "has many awards" do
				@user.should have_many(:awards)
			end
		end
		context "education" do
			it "respond to education" do
				@user.should respond_to(:education)
			end
			it "has many education" do
				@user.should have_many(:education)
			end
		end
		context "positions" do
			it "responds to positions" do
				@user.should respond_to(:positions)
			end
			it "has many positions" do
				@user.should have_many(:positions)
			end
		end
		context "skills" do
			it "responds to skills" do
				@user.should respond_to(:skills)
			end
			it "has many skills" do
				@user.should have_many(:skills)
			end
		end
		context "analyses" do
			it "responds to analyses" do
				@user.should respond_to(:analyses)
			end
			it "has many analyses" do
				@user.should have_many(:analyses)
			end
		end
		context "beta_codes" do
			it "responds to beta codes" do
				@user.should respond_to(:beta_codes)
			end
			it "belongs to a beta code" do
				@user.should belong_to(:beta_codes)
			end
		end
		context "beta_requests" do
			it "doesn't respond to beta requests" do
				@user.should_not respond_to(:beta_request)
			end
		end
		context "styles" do
			it "doesn't respond to styles" do
				@user.should_not respond_to(:styles)
			end
		end
	end
end
