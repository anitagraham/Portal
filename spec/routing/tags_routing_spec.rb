require "spec_helper"

describe TagtestsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tagtests" }.should route_to(:controller => "tagtests", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tagtests/new" }.should route_to(:controller => "tagtests", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tagtests/1" }.should route_to(:controller => "tagtests", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tagtests/1/edit" }.should route_to(:controller => "tagtests", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tagtests" }.should route_to(:controller => "tagtests", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tagtests/1" }.should route_to(:controller => "tagtests", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tagtests/1" }.should route_to(:controller => "tagtests", :action => "destroy", :id => "1")
    end

  end
end
