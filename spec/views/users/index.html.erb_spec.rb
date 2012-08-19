require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :email => "Email",
        :password => "Password",
        :verified => "",
        :verification_code => "Verification Code"
      ),
      stub_model(User,
        :email => "Email",
        :password => "Password",
        :verified => "",
        :verification_code => "Verification Code"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Verification Code".to_s, :count => 2
  end
end
