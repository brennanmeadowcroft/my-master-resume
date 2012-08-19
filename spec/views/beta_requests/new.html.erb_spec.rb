require 'spec_helper'

describe "beta_requests/new" do
  before(:each) do
    assign(:beta_request, stub_model(BetaRequest).as_new_record)
  end

  it "renders new beta_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_requests_path, :method => "post" do
    end
  end
end
