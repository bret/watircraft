require 'rubygems'
require 'spec'
require 'need'
need { '../lib/taza/page' }

describe Taza::Page do

  it "should have an element class method" do
    Taza::Page.should respond_to(:element)
  end

  it "should have a filter class method" do
    Taza::Page.should respond_to(:filter)
  end

  it "should store the block given to the element method in a method with the name of the parameter" do
    Taza::Page.element(:foo) do
      "bar"
    end
    Taza::Page.new.foo.should == "bar"
  end

  it "should change the size of filters hash when filter is called" do
    Taza::Page.filter :name => :something, :elements => [:foo] do
      "bar"
    end 
    Taza::Page.filters.size.should == 1 
  end

  it "should filter all elements if element argument is not provided" do
    Taza::Page.filter :name => :filter_everything do
      false
    end
    Taza::Page.element :foo do
      "nothing"
    end
    Taza::Page.element :apple do
      "also nothing"
    end
    lambda { Taza::Page.new.apple }.should raise_error(Taza::FilterError)
    lambda { Taza::Page.new.foo }.should raise_error(Taza::FilterError)
  end

  it "should not respond to a method if a filter containing that element name returns false" do
    Taza::Page.element :foo do
      "bar"
    end

    Taza::Page.filter :name => :whatever, :elements => [:foo] do
      false
    end

    lambda do
      Taza::Page.new.foo
    end.should raise_error(Taza::FilterError)
  end
end
