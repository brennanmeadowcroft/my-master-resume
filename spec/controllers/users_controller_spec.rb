require 'spec_helper'

describe UsersController do
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
        user = create(:user)
        get :show, id: user
        response.should require_login
      end
    end
    describe "GET #new" do
      it "assigns a new user to @user" do
        get :new
        assigns(:user).should be_a_new(User)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end
    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new user" do
          expect {
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end
        it "redirects to the new user" do
          post :create, user: attributes_for(:user)
          response.should redirect_to users_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new user" do
          expect {
            post :create, user: attributes_for(:invalid_user)
          }.to_not change(User, :count)
        end
        it "re-renders the new method" do
          post :create, user: attributes_for(:invalid_user)
          response.should render_template('new')
        end
      end
    end

    describe "GET #edit" do
      it "denies access" do
        user = create(:user)
        get :edit, id: user
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        user = create(:user)
        delete :destroy, id: user
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #show" do
      user = create(:user)
      get :edit, id: user
      response.should render_template('show')
    end
    describe "GET #edit" do
      it "assigns the user to @user" do
        user = create(:user)
        get :edit, id: user
        assigns(:user).should eq user
      end
      it "renders the :edit template" do
        user = create(:user)
        get :edit, id: user
        response.should render_template('edit')
      end
    end
    describe "PUT #update" do
      before :each do
        @user = create(:user)
      end
      context "valid attributes" do
        it "located the requested @user" do
          put :update, id: @user, user: attributes_for(:user)
          assigns(:user).should eq(@user)
        end
        it "changes @user's attributes" do
          put :update, id: @user, user: attributes_for(:user, first_name: "Brennan")
          @user.reload
          @user.first_name.should eq ("Brennan")
        end
        it "redirects to the updated user" do
          put :update, id: @user, user: attributes_for(:user)
          response.should redirect_to @user
        end
      end
      context "invalid attributes" do
        it "does not change @user's attributes" do
          put :update, id: @user, user: attributes_for(:user, description: "")
          @user.reload
          @user.description.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @user, user: attributes_for(:invalid_user)
          response.should render_template('edit')
        end
      end
      context "Linked In" do end
      context "Import" do end
    end
  end

  shared_examples("admin access")
    describe "GET #index" do
      it "denies access" do
        get :index
        response.should require_login
      end
    end

    describe "DELETE destroy" do
      before :each do
        @user = create(:user)
      end
      it "deletes the user" do
        expect {
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end
      it "redirects to users#index" do
        delete :destroy, id: @user
        response.should redirect_to users_url
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
      it_behaves_like "admin access"
    end
    context "adminstrator IS NOT the owner" do
      before :each do 
        # The first user is assigned to everything, need to build the second user to access the records (user_id = 2)
        create(:user)
        set_user_session build(:admin)
      end

      it_behaves_like "public access"
      it_behaves_like "admin access"
    end
  end

  # A visitor is not logged in and trying to view a record
  describe "non-signed in access" do
    it_behaves_like "public access"
  end

end
