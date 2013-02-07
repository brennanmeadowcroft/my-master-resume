require 'spec_helper'

describe BetaRequestsController do
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
        beta_request = create(:beta_request)
        get :show, id: beta_request
        response.should require_login
      end
    end
    describe "GET #new" do
      it "denies access" do
        get :new
        response.should render_template('new')
      end
    end
    describe "GET #edit" do
      it "denies access" do
        beta_request = create(:beta_request)
        get :edit, id: beta_request
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        beta_request = create(:beta_request)
        delete :destroy, id: beta_request
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new beta_request to @beta_request" do
        get :new
        assigns(:beta_request).should be_a_new(BetaRequest)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the beta_request to @beta_request" do
        beta_request = create(:beta_request)
        get :edit, id: beta_request
        assigns(:beta_request).should eq beta_request
      end
      it "renders the :edit template" do
        beta_request = create(:beta_request)
        get :edit, id: beta_request
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new beta_request" do
          expect {
            post :create, beta_request: attributes_for(:beta_request)
          }.to change(BetaRequest, :count).by(1)
        end
        it "redirects to the new beta_request" do
          post :create, beta_request: attributes_for(:beta_request)
          response.should redirect_to request_invite_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new beta_request" do
          expect {
            post :create, beta_request: attributes_for(:invalid_beta_request)
          }.to_not change(BetaRequest, :count)
        end
        it "re-renders the new method" do
          post :create, beta_request: attributes_for(:invalid_beta_request)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @beta_request = create(:beta_request)
      end
      context "valid attributes" do
        it "located the requested @beta_request" do
          put :update, id: @beta_request, beta_request: attributes_for(:beta_request, beta_code_id: 1)
          assigns(:beta_request).should eq(@beta_request)
        end
        it "changes @beta_request's attributes" do
          put :update, id: @beta_request, beta_request: attributes_for(:beta_request, email: "brennan@mymasterresume.com")
          @beta_request.reload
          @beta_request.email.should eq ("brennan@mymasterresume.com")
        end
        it "redirects to the updated beta_request" do
          put :update, id: @beta_request, beta_request: attributes_for(:beta_request)
          response.should redirect_to beta_requests_url
        end
      end
      context "invalid attributes" do
        it "does not change @beta_request's attributes" do
          put :update, id: @beta_request, beta_request: attributes_for(:beta_request, email: "")
          @beta_request.reload
          @beta_request.email.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @beta_request, beta_request: attributes_for(:invalid_beta_request)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @beta_request = create(:beta_request)
      end
      it "deletes the beta_request" do
        expect {
          delete :destroy, id: @beta_request
        }.to change(BetaRequest, :count).by(-1)
      end
      it "redirects to beta_requests#index" do
        delete :destroy, id: @beta_request
        response.should redirect_to beta_requests_url
      end
    end
  end

  # A user is logged in as themselves and trying to view a record
  describe "current user access" do
    before :each do 
      set_user_session create(:user)
    end

    it_behaves_like "public access"
  end

  # An administrator is logged in as themselves and trying to view a record
  describe "administrator access" do
    before :each do 
      # The first user is assigned to everything, need to build the second user to access the records (user_id = 2)
      set_user_session create(:admin)
    end

    it_behaves_like "full access"
  end

  # A visitor is not logged in and trying to view a record
  describe "non-signed in access" do
    it_behaves_like "public access"
  end

end
