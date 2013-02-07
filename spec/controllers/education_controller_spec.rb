require 'spec_helper'

describe EducationController do
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
        education = create(:education)
        get :show, id: education
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
        education = create(:education)
        get :edit, id: education
        response.should require_login
      end
    end
    describe "DELETE #destroy" do
      it "denies access" do
        education = create(:education)
        delete :destroy, id: education
        response.should require_login
      end
    end
  end

  # Full Access
  shared_examples("full access") do 
    describe "GET #new" do
      it "assigns a new education to @education" do
        get :new
        assigns(:education).should be_a_new(Education)
      end
      it "renders the :new template" do
        get :new
        response.should render_template('new')
      end
    end

    describe "GET #edit" do
      it "assigns the education to @education" do
        education = create(:education)
        get :edit, id: education
        assigns(:education).should eq education
      end
      it "renders the :edit template" do
        education = create(:education)
        get :edit, id: education
        response.should render_template('edit')
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new education" do
          expect {
            post :create, education: attributes_for(:education)
          }.to change(Education, :count).by(1)
        end
        it "redirects to the new education" do
          post :create, education: attributes_for(:education)
          response.should redirect_to master_resumes_url
        end
      end
      context "with invalid attributes" do
        it "does not save the new education" do
          expect {
            post :create, education: attributes_for(:invalid_education)
          }.to_not change(Education, :count)
        end
        it "re-renders the new method" do
          post :create, education: attributes_for(:invalid_education)
          response.should render_template('new')
        end
      end
    end

    describe "PUT #update" do
      before :each do
        @education = create(:education)
      end
      context "valid attributes" do
        it "located the requested @education" do
          put :update, id: @education, education: attributes_for(:education)
          assigns(:education).should eq(@education)
        end
        it "changes @education's attributes" do
          put :update, id: @education, education: attributes_for(:education, school: "Someplace Else")
          @education.reload
          @education.school.should eq ("Someplace Else")
        end
        it "redirects to the updated education" do
          put :update, id: @education, education: attributes_for(:education)
          response.should redirect_to master_resumes_url
        end
      end
      context "invalid attributes" do
        it "does not change @education's attributes" do
          put :update, id: @education, education: attributes_for(:education, school: "")
          @education.reload
          @education.school.should_not eq("")
        end
        it "re-renders the edit method" do
          put :update, id: @education, education: attributes_for(:invalid_education)
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE destroy" do
      before :each do
        @education = create(:education)
      end
      it "deletes the education" do
        expect {
          delete :destroy, id: @education
        }.to change(Education, :count).by(-1)
      end
      it "redirects to educations#index" do
        delete :destroy, id: @education
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
