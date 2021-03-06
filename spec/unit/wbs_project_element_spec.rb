require 'spec_helper'

describe WbsProjectElement do
  before :each do
    @project = FactoryGirl.create(:project)
    @pe_wbs_project = FactoryGirl.create(:pe_wbs_project, :wbs_type => "Activity", :project => @project)
    @wbs_project_element = FactoryGirl.create(:wbs_project_element, :is_root => true, :pe_wbs_project => @pe_wbs_project)
  end

  it "should be valid" do
    @wbs_project_element.should be_valid
  end

  it "should not be valid without name" do
    @wbs_project_element.name = ""
    @wbs_project_element.should_not be_valid
  end

  it "should not be from Library" do
    @wbs_project_element.is_from_library_and_is_leaf?.should be_false
  end

  it "Duplicate project element" do
    @wbs_project_element2=@wbs_project_element.amoeba_dup
  end

  describe "is_from_library_and_is_leaf?" do
    before :each do
      @project = FactoryGirl.create(:project)
      @wbs_activity = FactoryGirl.create(:wbs_activity)
      @wbs_activity_element=FactoryGirl.create(:wbs_activity_element)
      @pe_wbs_project = FactoryGirl.create(:pe_wbs_project, :wbs_type => "Activity", :project => @project)
      @wbs_project_element2 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project,:wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
      @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project,:wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
    end

    it "should return false if  wbs_activity is nil && wbs_activity_element is nil && parent.can_get_new_child is nil" do
      @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project,:wbs_activity => nil, :wbs_activity_element => nil)
      @wbs_project_element3.parent= @wbs_project_element
      @wbs_project_element3.parent.can_get_new_child=nil
      @wbs_project_element3.is_from_library_and_is_leaf?.should be_false
    end

    it "should return true if has children" do
      @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project, :wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
      @wbs_project_element.parent= @wbs_project_element3
      @wbs_project_element.save
      @wbs_project_element3.is_from_library_and_is_leaf?.should be_true
    end

    it "should return true if not has a children and can have a children" do
      @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project, :wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
      @wbs_project_element3.parent= @wbs_project_element
      @wbs_project_element.can_get_new_child=true
      @wbs_project_element3.save
      @wbs_project_element.save
      @wbs_project_element3.is_from_library_and_is_leaf?.should be_true
    end
    #it "should return true if not has a children and can have a children" do
    #  @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project,:wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
    #  @wbs_project_element3.parent = @wbs_project_element
    #
    #  @wbs_project_element3.parent.can_get_new_child=true
    #  @wbs_project_element3.is_from_library_and_is_leaf?.should be_false
    #end
    it "should return false if not has a children and can't have a children" do
      @wbs_project_element3 = FactoryGirl.create(:wbs_project_element, :is_root => false, :pe_wbs_project => @pe_wbs_project,:wbs_activity => @wbs_activity, :wbs_activity_element => @wbs_activity_element)
      @wbs_project_element3.parent = @wbs_project_element
      @wbs_project_element3.is_from_library_and_is_leaf?.should be_false
    end
  end

end
