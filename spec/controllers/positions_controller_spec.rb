require 'spec_helper'

describe PositionsController do
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
        position = create(:position)
        get :show, id: position
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
        position = create(:position)
        get :edit, id: position
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        position = create(:position)
        delete :destroy, id: position
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new position to @position" do
        get :new
        assigns(:position).should be_a_new(Position)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the position to @position" do
        position = create(:position)
        get :edit, id: position
        assigns(:position).should eq position
      end
      it "renders the :edit template" do
        position = create(:position)
        get :edit, id: position
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new position" do
          expect {
            post :create, position: attributes_for(:position)
          }.to change(Position, :count).by(1)
        end
        it "redirects to the new position" do
          post :create, position: attributes_for(:position)
          response.should redirect_to master_resumes_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new position" do
          expect {
            post :create, position: attributes_for(:invalid_position)
          }.to_not change(Position, :count)
        end
        it "re-renders the new method" do
          post :create, position: attributes_for(:invalid_position)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @position = create(:position)
      end
      context "valid attributes" do
        it "located the requested @position" do
          put :update, id: @position, position: attributes_for(:position)
          assigns(:position).should eq(@position)
        end
        it "changes @position's attributes" do
          put :update, id: @position, position: attributes_for(:position, company: "Someplace Else")
          @position.reload
          @position.company.should eq ("Someplace Else")
        end
        it "redirects to the updated position" do
          put :update, id: @position, position: attributes_for(:position)
          response.should redirect_to master_resumes_url
        end
      end
      context "invalid attributes" do
        it "does not change @position's attributes" do
          put :update, id: @position, position: attributes_for(:position, company: "")
          @position.reload
          @position.company.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @position, position: attributes_for(:invalid_position)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @position = create(:position)
      end
      it "deletes the position" do
        expect {
          delete :destroy, id: @position
        }.to change(Position, :count).by(-1)
      end
      it "redirects to positions#index" do
        delete :destroy, id: @position
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
