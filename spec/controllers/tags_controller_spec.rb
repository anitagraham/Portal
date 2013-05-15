require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe TagtestsController do

  def mock_tagtest(stubs={})
    @mock_tagtest ||= mock_model(Tagtest, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tagtests as @tagtests" do
      Tagtest.stub(:all) { [mock_tagtest] }
      get :index
      assigns(:tagtests).should eq([mock_tagtest])
    end
  end

  describe "GET show" do
    it "assigns the requested tagtest as @tagtest" do
      Tagtest.stub(:find).with("37") { mock_tagtest }
      get :show, :id => "37"
      assigns(:tagtest).should be(mock_tagtest)
    end
  end

  describe "GET new" do
    it "assigns a new tagtest as @tagtest" do
      Tagtest.stub(:new) { mock_tagtest }
      get :new
      assigns(:tagtest).should be(mock_tagtest)
    end
  end

  describe "GET edit" do
    it "assigns the requested tagtest as @tagtest" do
      Tagtest.stub(:find).with("37") { mock_tagtest }
      get :edit, :id => "37"
      assigns(:tagtest).should be(mock_tagtest)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created tagtest as @tagtest" do
        Tagtest.stub(:new).with({'these' => 'params'}) { mock_tagtest(:save => true) }
        post :create, :tagtest => {'these' => 'params'}
        assigns(:tagtest).should be(mock_tagtest)
      end

      it "redirects to the created tagtest" do
        Tagtest.stub(:new) { mock_tagtest(:save => true) }
        post :create, :tagtest => {}
        response.should redirect_to(tagtest_url(mock_tagtest))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tagtest as @tagtest" do
        Tagtest.stub(:new).with({'these' => 'params'}) { mock_tagtest(:save => false) }
        post :create, :tagtest => {'these' => 'params'}
        assigns(:tagtest).should be(mock_tagtest)
      end

      it "re-renders the 'new' template" do
        Tagtest.stub(:new) { mock_tagtest(:save => false) }
        post :create, :tagtest => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tagtest" do
        Tagtest.stub(:find).with("37") { mock_tagtest }
        mock_tagtest.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tagtest => {'these' => 'params'}
      end

      it "assigns the requested tagtest as @tagtest" do
        Tagtest.stub(:find) { mock_tagtest(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tagtest).should be(mock_tagtest)
      end

      it "redirects to the tagtest" do
        Tagtest.stub(:find) { mock_tagtest(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tagtest_url(mock_tagtest))
      end
    end

    describe "with invalid params" do
      it "assigns the tagtest as @tagtest" do
        Tagtest.stub(:find) { mock_tagtest(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tagtest).should be(mock_tagtest)
      end

      it "re-renders the 'edit' template" do
        Tagtest.stub(:find) { mock_tagtest(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tagtest" do
      Tagtest.stub(:find).with("37") { mock_tagtest }
      mock_tagtest.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tagtests list" do
      Tagtest.stub(:find) { mock_tagtest }
      delete :destroy, :id => "1"
      response.should redirect_to(tagtests_url)
    end
  end

end
