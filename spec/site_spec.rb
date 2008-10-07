require 'rubygems'
require 'spec/spec_helper'
require 'taza/site'

describe Taza::Site do

  before :all do
    Foo = Class.new(Taza::Site)
    Foo.any_instance.stubs(:path).returns(File.join("spec","pages","foo","*.rb"))
  end
  
  before :each do
    Taza::Browser.stubs(:create).returns(:apple_pie)
  end

  it "should respond to a method correlating to a page class" do
    f = Foo.new
    f.respond_to?(:bar).should == true
  end

  it "should yield an instance of a page class" do
    f = Foo.new
    barzor = nil
    f.bar do |bar|
      barzor = bar
    end
    barzor.should be_an_instance_of(Bar)
  end

  it "should accept a browser instance" do
    foo = Foo.new(:browser => :zorro)
    foo.browser.should eql(:zorro)
  end

  it "should create a browser instance if one is not provided" do
    foo = Foo.new
    foo.browser.should eql(:apple_pie)
  end

end
