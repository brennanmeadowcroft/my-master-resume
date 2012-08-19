require 'spec_helper'

describe "beta_requests/index" do
  before(:each) do
    assign(:beta_requests, [
      stub_model(BetaRequest),
      stub_model(BetaRequest)
    ])
  end

  it "renders a list of beta_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
