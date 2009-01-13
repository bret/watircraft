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
  
  it "should populate the fields corresponding to the keys in the hash" do
    name_element = stub
    name_element.stubs(:set).with('Zachary Taylor')
    rank_element = stub
    rank_element.stubs(:set).with('General')
    serial_no_element = stub
    @page_class.class_eval do
      field(:name){name_element}
      field(:rank){rank_element}
      field(:serial_no){serial_no_element}
    end
    page = @page_class.new
    page.populate :name => 'Zachary Taylor', :rank => 'General'
  end

  it "should validate a page" do
    name_element = stub
    name_element.stubs(:display_value).returns('Zachary Taylor')
    rank_element = stub
    rank_element.stubs(:display_value).returns('General')
    serial_no_element = stub
    @page_class.class_eval do
      field(:name){name_element}
      field(:rank){rank_element}
      field(:serial_no){serial_no_element}
    end
    page = @page_class.new
    page.validate :name => 'Zachary Taylor', :rank => 'General'
  end
  
end
