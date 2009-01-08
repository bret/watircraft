require 'spec/spec_helper'
require 'taza/page'

describe Taza::Page do
  
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
    Taza::Page.element(:boo){|baz| baz}
    Taza::Page.new.boo("rofl").should == "rofl"
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
    Taza::Page.element(:foo) do
      "bar"
    end
    Taza::Page.new.foo.should == "bar"
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
    foo = Class::new(superclass=Taza::Page)
    foo.elements.should_not be_nil
    foo.elements.should be_empty
  end

  it "should have empty filters on a new class" do
    foo = Class::new(superclass=Taza::Page)
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
end
