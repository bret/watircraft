require 'rubygems'
require 'need'
need { '../lib/taza/page' }

describe Page do

  it "should have an element class method" do
    Page.should respond_to(:element)
  end

  it "should have a filter class method" do
    Page.should respond_to(:filter)
  end

  it "should store the block given to the element method in a method with the name of the parameter" do
    Page.element(:foo) do
      "bar"
    end
    Page.new.foo.should == "bar"
  end

  it "should change the size of filters hash when filter is called" do
    Page.filter :name => :something, :elements => [:foo] do
      "bar"
    end 
    Page.filters.size.should == 1 
  end

  it "should filter all elements if element argument is not provided" do
    Page.filter :name => :filter_everything do
      false
    end
    Page.element :foo do
      "nothing"
    end
    Page.element :apple do
      "also nothing"
    end
    lambda { Page.new.apple }.should raise_error(FilterError)
    lambda { Page.new.foo }.should raise_error(FilterError)
  end

  it "should not respond to a method if a filter containing that element name returns false" do
    Page.element :foo do
      "bar"
    end

    Page.filter :name => :whatever, :elements => [:foo] do
      false
    end

    lambda do
      Page.new.foo
    end.should raise_error(FilterError)
  end
end
