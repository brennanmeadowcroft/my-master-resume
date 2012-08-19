require 'spec_helper'

describe "beta_requests/edit" do
  before(:each) do
    @beta_request = assign(:beta_request, stub_model(BetaRequest))
  end

  it "renders the edit beta_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_requests_path(@beta_request), :method => "post" do
    end
  end
end
