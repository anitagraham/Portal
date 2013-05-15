require 'spec_helper'

describe "tagtests/show.html.erb" do
  before(:each) do
    @tagtest = assign(:tagtest, stub_model(Tagtest,
      :Name => "Name",
      :css_class => "Css Class"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Css Class/)
  end
end
