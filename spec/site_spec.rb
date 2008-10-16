require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe Taza::Site do

  before :all do
    Foo = Class.new(Taza::Site)
    Foo.any_instance.stubs(:path).returns(File.join("spec","pages","foo","*.rb"))
  end

  before :each do
    ENV['browser'] = nil
    ENV['driver'] = nil
    Taza::Settings.stubs(:config_file).returns({})
  end

  it "should create a browser using environment variables" do
    Taza::Browser.expects(:create_watir_ie)
    ENV['browser'] = 'ie'
    ENV['driver'] = 'watir'
    f = Foo.new
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
    Taza::Browser.stubs(:create).returns(:apple_pie)
    foo = Foo.new
    foo.browser.should eql(:apple_pie)
  end

  it "should still close browser if an error is raised" do
    browser = Object.new
    browser.expects(:close)
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new { |site| raise StandardError}}.should raise_error
  end


  it "should raise browser close error if no other errors" do
    browser = Object.new
    browser.expects(:close).raises(StandardError,"BrowserCloseError")
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new {}}.should raise_error(StandardError,"BrowserCloseError")
  end
  
  it "should raise error inside block if both it and browser.close throws an error" do
    browser = Object.new
    browser.expects(:close).raises(StandardError,"BrowserCloseError")
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new { |site| raise StandardError, "innererror" }}.should raise_error(StandardError,"innererror")
  end

  it "should close a browser if block given" do
    browser = Object.new
    browser.expects(:close)
    Taza::Browser.stubs(:create).returns(browser)
    Foo.new do |site|
    end
  end

  it "should yield itself upon initialization" do
    Taza::Browser.stubs(:create).returns(stub_browser)
    foo = nil
    f = Foo.new do |site|
      foo = site
    end
    foo.should eql(f)
  end

  it "should yield after page methods have been setup" do
    Taza::Browser.stubs(:create).returns(stub_browser)
    klass = Class::new(Taza::Site)
    klass.any_instance.stubs(:path).returns(File.join("spec","pages","foo","*.rb"))
    klass.new do |site|
      site.should respond_to(:bar)
    end
  end
  it "should yield after browser has been setup" do
    Taza::Browser.stubs(:create).returns(stub_browser)
    klass = Class::new(Taza::Site)
    klass.any_instance.stubs(:path).returns(File.join("spec","pages","foo","*.rb"))
    klass.new do |site|
      site.browser.should_not be_nil
    end
  end

  it "should pass its browser instance to its pages " do
    Taza::Browser.stubs(:create).returns(:apple_pie)
    foo = Foo.new
    foo.bar.browser.should eql(:apple_pie)
  end

  def stub_browser
    browser = Object.new
    browser.stubs(:close)
    browser
  end
end
