require 'spec_helper'

describe "tagtests/new.html.erb" do
  before(:each) do
    assign(:tagtest, stub_model(Tagtest,
      :Name => "MyString",
      :css_class => "MyString"
    ).as_new_record)
  end

  it "renders new tagtest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tagtests_path, :method => "post" do
      assert_select "input#tagtest_Name", :name => "tagtest[Name]"
      assert_select "input#tagtest_css_class", :name => "tagtest[css_class]"
    end
  end
end
