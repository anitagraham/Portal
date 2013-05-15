require 'spec_helper'

describe "tagtests/index.html.erb" do
  before(:each) do
    assign(:tagtests, [
      stub_model(Tagtest,
        :Name => "Name",
        :css_class => "Css Class"
      ),
      stub_model(Tagtest,
        :Name => "Name",
        :css_class => "Css Class"
      )
    ])
  end

  it "renders a list of tagtests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Css Class".to_s, :count => 2
  end
end
