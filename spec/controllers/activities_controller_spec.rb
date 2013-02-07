require 'spec_helper'

describe ActivitiesController do
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
        activity = create(:activity)
        get :show, id: activity
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
        activity = create(:activity)
        get :edit, id: activity
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        activity = create(:activity)
        delete :destroy, id: activity
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new activity to @activity" do
        get :new
        assigns(:activity).should be_a_new(Activity)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the activity to @activity" do
        activity = create(:activity)
        get :edit, id: activity
        assigns(:activity).should eq activity
      end
      it "renders the :edit template" do
        activity = create(:activity)
        get :edit, id: activity
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new activity" do
          expect {
            post :create, activity: attributes_for(:activity)
          }.to change(Activity, :count).by(1)
        end
        it "redirects to the new activity" do
          post :create, activity: attributes_for(:activity)
          response.should redirect_to master_resumes_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new activity" do
          expect {
            post :create, activity: attributes_for(:invalid_activity)
          }.to_not change(Activity, :count)
        end
        it "re-renders the new method" do
          post :create, activity: attributes_for(:invalid_activity)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @activity = create(:activity)
      end
      context "valid attributes" do
        it "located the requested @activity" do
          put :update, id: @activity, activity: attributes_for(:activity)
          assigns(:activity).should eq(@activity)
        end
        it "changes @activity's attributes" do
          put :update, id: @activity, activity: attributes_for(:activity, organization: "Someplace Else")
          @activity.reload
          @activity.organization.should eq ("Someplace Else")
        end
        it "redirects to the updated activity" do
          put :update, id: @activity, activity: attributes_for(:activity)
          response.should redirect_to master_resumes_url
        end
      end
      context "invalid attributes" do
        it "does not change @activity's attributes" do
          put :update, id: @activity, activity: attributes_for(:activity, organization: "")
          @activity.reload
          @activity.organization.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @activity, activity: attributes_for(:invalid_activity)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @activity = create(:activity)
      end
      it "deletes the activity" do
        expect {
          delete :destroy, id: @activity
        }.to change(Activity, :count).by(-1)
      end
      it "redirects to activities#index" do
        delete :destroy, id: @activity
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
        create(:user)
        set_user_session create(:admin)
      end

      it_behaves_like "public access"
    end
  end

  # A visitor is not logged in and trying to view a record
  describe "non-signed in access" do
    it_behaves_like "public access"
  end

end
