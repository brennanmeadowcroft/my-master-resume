require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :email => "MyString",
      :password => "MyString",
      :verified => "",
      :verification_code => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_password", :name => "user[password]"
      assert_select "input#user_verified", :name => "user[verified]"
      assert_select "input#user_verification_code", :name => "user[verification_code]"
    end
  end
end
