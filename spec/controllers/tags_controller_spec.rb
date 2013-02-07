require 'spec_helper'

describe TagsController do
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
        tag = create(:tag)
        get :show, id: tag
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
        tag = create(:tag)
        get :edit, id: tag
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        tag = create(:tag)
        delete :destroy, id: tag
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new tag to @tag" do
        get :new
        assigns(:tag).should be_a_new(Tag)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the tag to @tag" do
        tag = create(:tag)
        get :edit, id: tag
        assigns(:tag).should eq tag
      end
      it "renders the :edit template" do
        tag = create(:tag)
        get :edit, id: tag
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new tag" do
          expect {
            post :create, tag: attributes_for(:tag)
          }.to change(Tag, :count).by(1)
        end
        it "redirects to the new tag" do
          post :create, tag: attributes_for(:tag)
          response.should redirect_to tags_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new tag" do
          expect {
            post :create, tag: attributes_for(:invalid_tag)
          }.to_not change(Tag, :count)
        end
        it "re-renders the new method" do
          post :create, tag: attributes_for(:invalid_tag)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @tag = create(:tag)
      end
      context "valid attributes" do
        it "located the requested @tag" do
          put :update, id: @tag, tag: attributes_for(:tag)
          assigns(:tag).should eq(@tag)
        end
        it "changes @tag's attributes" do
          put :update, id: @tag, tag: attributes_for(:tag, description: "Someplace Else")
          @tag.reload
          @tag.description.should eq ("Someplace Else")
        end
        it "redirects to the updated tag" do
          put :update, id: @tag, tag: attributes_for(:tag)
          response.should redirect_to tags_url
        end
      end
      context "invalid attributes" do
        it "does not change @tag's attributes" do
          put :update, id: @tag, tag: attributes_for(:tag, description: "")
          @tag.reload
          @tag.description.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @tag, tag: attributes_for(:invalid_tag)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @tag = create(:tag)
      end
      it "deletes the tag" do
        expect {
          delete :destroy, id: @tag
        }.to change(Tag, :count).by(-1)
      end
      it "redirects to tags#index" do
        delete :destroy, id: @tag
        response.should redirect_to tags_url
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
