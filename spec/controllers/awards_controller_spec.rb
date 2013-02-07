require 'spec_helper'

describe AwardsController do
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
        award = create(:award)
        get :show, id: award
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
        award = create(:award)
        get :edit, id: award
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        award = create(:award)
        delete :destroy, id: award
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new award to @award" do
        get :new
        assigns(:award).should be_a_new(Award)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the award to @award" do
        award = create(:award)
        get :edit, id: award
        assigns(:award).should eq award
      end
      it "renders the :edit template" do
        award = create(:award)
        get :edit, id: award
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new award" do
          expect {
            post :create, award: attributes_for(:award)
          }.to change(Award, :count).by(1)
        end
        it "redirects to the new award" do
          post :create, award: attributes_for(:award)
          response.should redirect_to master_resumes_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new award" do
          expect {
            post :create, award: attributes_for(:invalid_award)
          }.to_not change(Award, :count)
        end
        it "re-renders the new method" do
          post :create, award: attributes_for(:invalid_award)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @award = create(:award)
      end
      context "valid attributes" do
        it "located the requested @award" do
          put :update, id: @award, award: attributes_for(:award)
          assigns(:award).should eq(@award)
        end
        it "changes @award's attributes" do
          put :update, id: @award, award: attributes_for(:award, description: "Someplace Else")
          @award.reload
          @award.description.should eq ("Someplace Else")
        end
        it "redirects to the updated award" do
          put :update, id: @award, award: attributes_for(:award)
          response.should redirect_to master_resumes_url
        end
      end
      context "invalid attributes" do
        it "does not change @award's attributes" do
          put :update, id: @award, award: attributes_for(:award, description: "")
          @award.reload
          @award.description.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @award, award: attributes_for(:invalid_award)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @award = create(:award)
      end
      it "deletes the award" do
        expect {
          delete :destroy, id: @award
        }.to change(Award, :count).by(-1)
      end
      it "redirects to awards#index" do
        delete :destroy, id: @award
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
