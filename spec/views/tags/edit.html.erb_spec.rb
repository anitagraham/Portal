require 'spec_helper'

describe "tagtests/edit.html.erb" do
  before(:each) do
    @tagtest = assign(:tagtest, stub_model(Tagtest,
      :Name => "MyString",
      :css_class => "MyString"
    ))
  end

  it "renders the edit tagtest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tagtests_path(@tagtest), :method => "post" do
      assert_select "input#tagtest_Name", :name => "tagtest[Name]"
      assert_select "input#tagtest_css_class", :name => "tagtest[css_class]"
    end
  end
end
