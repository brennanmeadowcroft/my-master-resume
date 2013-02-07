require 'spec_helper'

describe SkillsController do
#################################################################################
#  Shared Examples
#################################################################################
  # Public Access (Not logged In)
  shared_examples("public access") do 
    describe "GET #index" do
      it "denies access" do
        get :index
        response.should require_login
      end
    end
    describe "GET #show" do
      it "denies access" do
        skill = create(:skill)
        get :show, id: skill
        response.should require_login
      end
    end
    describe "GET #new" do
      it "denies access" do
        get :new
        response.should require_login
      end
    end
    describe "GET #edit" do
      it "denies access" do
        skill = create(:skill)
        get :edit, id: skill
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        skill = create(:skill)
        delete :destroy, id: skill
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new skill to @skill" do
        get :new
        assigns(:skill).should be_a_new(Skill)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the skill to @skill" do
        skill = create(:skill)
        get :edit, id: skill
        assigns(:skill).should eq skill
      end
      it "renders the :edit template" do
        skill = create(:skill)
        get :edit, id: skill
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new skill" do
          expect {
            post :create, skill: attributes_for(:skill)
          }.to change(Skill, :count).by(1)
        end
        it "redirects to the new skill" do
          post :create, skill: attributes_for(:skill)
          response.should redirect_to master_resumes_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new skill" do
          expect {
            post :create, skill: attributes_for(:invalid_skill)
          }.to_not change(Skill, :count)
        end
        it "re-renders the new method" do
          post :create, skill: attributes_for(:invalid_skill)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @skill = create(:skill)
      end
      context "valid attributes" do
        it "located the requested @skill" do
          put :update, id: @skill, skill: attributes_for(:skill)
          assigns(:skill).should eq(@skill)
        end
        it "changes @skill's attributes" do
          put :update, id: @skill, skill: attributes_for(:skill, description: "Someplace Else")
          @skill.reload
          @skill.description.should eq ("Someplace Else")
        end
        it "redirects to the updated skill" do
          put :update, id: @skill, skill: attributes_for(:skill)
          response.should redirect_to master_resumes_url
        end
      end
      context "invalid attributes" do
        it "does not change @skill's attributes" do
          put :update, id: @skill, skill: attributes_for(:skill, description: "")
          @skill.reload
          @skill.description.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @skill, skill: attributes_for(:invalid_skill)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @skill = create(:skill)
      end
      it "deletes the skill" do
        expect {
          delete :destroy, id: @skill
        }.to change(Skill, :count).by(-1)
      end
      it "redirects to skills#index" do
        delete :destroy, id: @skill
        response.should redirect_to master_resumes_url
      end
    end
  end

  # A user is logged in as themselves and trying to view a record
  describe "current user access" do
    context "current user IS the owner" do
      before :each do 
        set_user_session(create(:user))
      end

      it_behaves_like "full access"
    end
    context "current user IS NOT the owner" do
      before :each do 
        # The first user is assigned to everything, need to build the second user to access the records (user_id = 2)
        create(:user)
        set_user_session create(:user)
      end

      it_behaves_like "public access"
    end
  end

  # An administrator is logged in as themselves and trying to view a record
  describe "administrator access" do
    context "administrator IS the owner" do
      before :each do 
        set_user_session create(:admin)
      end

      it_behaves_like "full access"
    end
    context "adminstrator IS NOT the owner" do
      before :each do 
        # The first user is assigned to everything, need to build the second user to access the records (user_id = 2)
        create(:user)
        set_user_session build(:admin)
      end

      it_behaves_like "public access"
    end
  end

  # A visitor is not logged in and trying to view a record
  describe "non-signed in access" do
    it_behaves_like "public access"
  end

end
