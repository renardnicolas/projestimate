require 'spec_helper'

describe LanguagesController do

  before :each do
    login_as_admin

    @language = FactoryGirl.create(:language)
    @params = { :id => @language.id }
  end

  describe "GET index" do
    it "renders the index template" do
      get :index
      response.should render_template("index")
    end
  end

  describe "New" do
    it "renders the new template" do
      get :new
      response.should render_template("new")
    end
  end

  describe "edit" do
    it "renders the new template" do
      get :edit, @params
      response.should render_template("edit")
    end
  end

  describe "create" do
    it "renders the create template" do
      @params = { :name => "Breton", :locale => "br" }
      post :create, @params
      response.should be_success
    end
    #it "renders the create template" do
    #  @params = { :name => "Breton", :locale => "br" }
    #  post :create, @params
    #  response.should redirect_to redirect(languages_path)
    #end
  end

  describe "PUT update" do
    before :each do
      @new_language = FactoryGirl.create(:language)
    end

    context "with valid params" do
      it "updates the requested record_status" do
        put :update, id: @new_language, language: FactoryGirl.attributes_for(:language)
        response.should be_success
      end
    end
  end

  describe "DELETE destroy" do
    #it "destroys the requested record_status" do
    #    @params = { :id => @language.id }
    #    delete :destroy, @params
    #    response.should be_success
    #end
    it "redirects to the record_statuses list" do
      @params = { :id => @language.id }
      delete :destroy, @params
      response.should redirect_to(languages_url)
    end
  end
end