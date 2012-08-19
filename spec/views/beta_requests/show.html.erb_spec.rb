require 'spec_helper'

describe "beta_requests/show" do
  before(:each) do
    @beta_request = assign(:beta_request, stub_model(BetaRequest))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
