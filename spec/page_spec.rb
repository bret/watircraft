require 'spec/spec_helper'
require 'taza/page'
require 'taza/site'

describe Taza::Page do
  before :each do
    @page_class = Class.new(Taza::Page)
  end
  
  class ElementAndFilterContextExample < Taza::Page
    element(:sample_element) {browser}
    filter:sample_filter, :sample_element
    def sample_filter
      browser
    end
  end

  class RecursiveFilterExample < Taza::Page
    element(:foo) {}
    filter :sample_filter
    def sample_filter
      foo
      true
    end
  end

  it "should not enter a infinite loop if you call a filtered element inside of a filter" do
    page = RecursiveFilterExample.new
    lambda { page.foo }.should_not raise_error
  end

  it "should execute an element's block with the params provided for its method" do
    @page_class.element(:boo){|baz| baz}
    @page_class.new.boo("rofl").should == "rofl"
  end
  
  it "should execute elements and filters in the context of the page instance" do
    page = ElementAndFilterContextExample.new
    page.browser = :something
    page.sample_element.should eql(:something)
  end
  
  it "should add a filter to the classes filters" do
    ElementAndFilterContextExample.filters.size.should eql(1) 
  end
  
  it "should store the block given to the element method in a method with the name of the parameter" do
    @page_class.element(:foo) do
      "bar"
    end
    @page_class.new.foo.should == "bar"
  end

  class FilterAllElements < Taza::Page
    element(:foo) {}
    element(:apple) {}
    filter :false_filter

    def false_filter
      false
    end
  end
    
  it "should filter all elements if element argument is not provided" do
    lambda { FilterAllElements.new.apple }.should raise_error(Taza::FilterError)
    lambda { FilterAllElements.new.foo }.should raise_error(Taza::FilterError)
  end
  
  it "should have empty elements on a new class" do
    foo = @page_class
    foo.elements.should_not be_nil
    foo.elements.should be_empty
  end

  it "should have empty filters on a new class" do
    foo = @page_class
    foo.filters.should_not be_nil
    foo.filters.should be_empty
  end

  class FilterAnElement < Taza::Page
    attr_accessor :called_element_method
    element(:false_item) { @called_element_method = true}
    filter :false_filter, :false_item

    def false_filter
      false
    end
  end

  it "should raise a error if an elements is called and its filter returns false" do
    lambda { FilterAnElement.new.false_item }.should raise_error(Taza::FilterError)
  end
  
  it "should not call element block if filters fail" do
    page = FilterAnElement.new
    lambda { page.false_item }.should raise_error
    page.called_element_method.should_not be_true
  end

  class CheckOutPage < Taza::Page
    url 'check_out'
  end
  
  it "should goto the url relative to the site url" do
    browser = stub
    browser.expects(:goto).with('http://www.llamas.com')
    browser.expects(:goto).with('http://www.llamas.com/check_out')
    Taza::Settings.stubs(:config).returns(:url => 'http://www.llamas.com')    
    page = CheckOutPage.new
    page.site = Class.new(Taza::Site).new(:browser => browser)
    page.goto
  end  

  it "should report the full url of the page" do
    browser = stub
    browser.stubs(:goto)
    Taza::Settings.stubs(:config).returns(:url => 'http://www.llamas.com')    
    page = CheckOutPage.new
    page.site = Class.new(Taza::Site).new(:browser => browser)
    page.full_url.should == 'http://www.llamas.com/check_out'
  end
    
  it "should create elements for fields" do    
    @page_class.field(:foo) {'element'}
    @page_class.new.foo_field.should == 'element'
  end
  
  it "should allow you to override the suffix for fields" do
    @page_class.field(:foo, 'link') {'link element'}
    @page_class.new.foo_link.should == 'link element'
  end
  
  it "should return the display_value of the field's element" do
    element = stub
    element.stubs(:display_value).with().returns('tomorrow')
    @page_class.field(:foo) {element}
    page = @page_class.new
    page.foo_field.display_value.should == 'tomorrow'
    page.foo.should == 'tomorrow'
  end
  
  it "should call the set method of the element when the field= method is called" do
    element = stub
    element.stubs(:set).with('never').returns(nil)
    @page_class.field(:end_date) {element}
    page = @page_class.new
    page.end_date = 'never'
  end
  
  def uses_soldier_page
    name_element = stub
    rank_element = stub
    serial_no_element = stub
    @page_class.class_eval do
      field(:name){name_element}
      field(:rank){rank_element}
      field(:serial_no){serial_no_element}
    end
    @soldier_page = @page_class.new
    @soldier_page.name_field.stubs(:display_value).returns('Zachary Taylor')
    @soldier_page.rank_field.stubs(:display_value).returns('General')
    @soldier_page.serial_no_field.stubs(:display_value).returns('unknown')
  end
  
  it "should populate the fields corresponding to the keys in the hash" do
    uses_soldier_page
    @soldier_page.name_field.expects(:set).with('Zachary Taylor')
    @soldier_page.rank_field.expects(:set).with('General')
    @soldier_page.populate :name => 'Zachary Taylor', :rank => 'General'
  end

  it "should validate a page" do
    uses_soldier_page
    @soldier_page.validate :name => 'Zachary Taylor', :rank => 'General'
  end

  it "should allow you to define elements using human-form names" do
    @page_class.element('User Name'){'Tertulian'}
    @page_class.new.user_name.should == 'Tertulian'
  end
  
  it "should allow you to define fields using human-form names" do
    @page_class.field('User Name'){'Tertulian'}
    @page_class.new.user_name_field.should == 'Tertulian'
  end  

  def simple_page
    @page_class.class_eval do
      element(:link){}
      field(:name){}
    end
    @page_class.new
  end

  it "should list the page's elements" do
    simple_page.elements.should == ['link', 'name_field']
  end

  it "should list the page's fields" do
    simple_page.fields.should == ['name']
  end
  
  it "should list the values of all the fields" do
    uses_soldier_page
    @soldier_page.values.should == 
      {:name => 'Zachary Taylor', :rank => 'General', :serial_no => 'unknown'}
  end
  
  it "should list the values of the specified fields" do
    uses_soldier_page
    @soldier_page.values(['name', 'rank']).should ==
      {:name => 'Zachary Taylor', :rank => 'General'}
  end
  
  def exists_page
    link1_element = stub
    link1_element.stubs(:exist?).returns(true)
    link2_element = stub
    link2_element.stubs(:exist?).returns(false)
    @page_class.class_eval do
      element(:link1){link1_element}
      element(:link2){link2_element}
    end
    @page_class.new    
  end
  
  it "should determine whether an element exists" do
    page = exists_page
    page.element_exists?(:link1).should be_true
    page.element_exist?(:link1).should be_true
    page.element_exists?(:link2).should be_false
  end

  it "should report which defined elements exist" do
    page = exists_page
    expectation = {:link1 => true, :link2 => false}
    page.elements_exist?.should == expectation
    page.elements_exists?.should == expectation
  end
  
  it "should report whether selected elements exist" do
    page = exists_page
    expectation = {:link1 => true}
    page.elements_exist?([:link1]).should == expectation
  end
  
  it "should report that elements don't exist when not found errors are thrown" do
    link3_element = stub
    link3_element.stubs(:exist?).raises(Watir::Exception::UnknownFrameException)
    link4_element = stub
    link4_element.stubs(:exist?).raises(Watir::Exception::UnknownObjectException)
    @page_class.class_eval do
      element(:link3){link3_element}
      element(:link4){link4_element}
    end
    page = @page_class.new    
    page.element_exists?(:link3).should == false
    page.element_exists?(:link4).should == false
  end
  
  it "should allow you to create and reference a WatirCraft table" do
    @page_class.class_eval do
      element(:results_table){}
      table(:results) {}
    end
    @page_class.new.results.should be_a(WatirCraft::Table)
  end
  
  require 'spec/fake_table'
  it "should report whether a table has a specified row" do
    @page_class.class_eval do
      element(:results_table){FakeTable.new [:name => 'x']}
      table(:results) do
        field(:name){@row.element(:name)}
      end
    end
    
    @page_class.new.results.row(:name => 'x').should_not be_nil
  end
  
  it "should allow you to reference another field in a selected row" do
    @page_class.class_eval do
      element(:results_table) do FakeTable.new [
        {:letter => 'x', :number => 1}, 
        {:letter => 'y', :number => 2}
        ]
      end
      table(:results) do
        field(:name){@row.element(:letter)}
        field(:phone){@row.element(:number)}
      end
    end
    
    @page_class.new.results.row(:name => 'x').phone.should == 1
    @page_class.new.results.row(:phone => 2).name.should == 'y'
    
  end
  
end
