require 'spec_helper'

describe Resume do
	it "has a valid factory" do
		FactoryGirl.create(:resume).should be_valid
	end
	it "has a valid tag id" do
		FactoryGirl.build(:resume, tag_id: nil).should_not be_valid
	end
	describe "Associations" do
		before :each do
			@resume = FactoryGirl.create(:resume)
		end

		context "tags" do
			it "responds to tags" do 
				@resume.should respond_to(:tag)
			end
			it "belongs to tags" do
				@resume.should belong_to(:tag)
			end
		end
		context "styles" do
			it "responds to tags" do
				@resume.should respond_to(:tag)
			end
			it "belongs to a style" do
				@resume.should belong_to(:style)
			end
		end
	end
end

