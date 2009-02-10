require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe Taza::Site do

  before :all do
    @pages_path = File.join("spec","sandbox","pages","foo","**","*.rb")
    @flows_path = File.join("spec","sandbox","flows","*.rb")
    Foo = Class.new(Taza::Site)
  end

  before :each do
    Foo.any_instance.stubs(:pages_path).returns(@pages_path)
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
    Taza::Settings.stubs(:config_file).returns({})
    Taza::Settings.stubs(:environment_settings).returns({})
    Taza::Site.before_browser_closes {}
  end

  it "pages_path should not contain the site class name" do
    browser = stub_browser
    Taza::Browser.stubs(:create).returns(browser)
    Bax = Class.new(Taza::Site)
    Bax.new.pages_path.should eql(APP_ROOT + "/lib/pages/**/*.rb")
  end

  it "should have flows defined as instance methods" do
    browser = stub_browser
    Taza::Browser.stubs(:create).returns(browser)
    Barz = Class.new(Taza::Site)
    Barz.any_instance.stubs(:path).returns('spec/sandbox')
    Barz.any_instance.stubs(:flows_path).returns(@flows_path)
    Barz.new.batman_flow.should == "i am batman"
  end

  it "should open watir browsers at the configuration URL" do
    browser = stub_browser
    browser.expects(:goto).with('a_url')
    Taza::Browser.stubs(:create).returns(browser)
    Taza::Settings.stubs(:config).returns(:url => 'a_url')
    Foo.new
  end

  it "should yield an instance of a page class" do
    f = Foo.new(:browser => stub_browser)
    barzor = nil
    f.bar_page do |bar|
      barzor = bar
    end
    barzor.should be_an_instance_of(BarPage)
  end
  
  it "should return a page by name" do
    # Foo is a site, Bar is a page on the site
    site = Foo.new(:browser => stub_browser)
    site.bar_page.should be_an_instance_of(BarPage)
  end

  it "should return a page by method" do
    # Foo is a site, Bar is a page on the site
    site = Foo.new(:browser => stub_browser)
    site.page('bar').should be_an_instance_of(BarPage)
    site.page('Bar').should be_an_instance_of(BarPage)
  end
  
  it "should yield to a page" do
    site = Foo.new(:browser => stub_browser)
    the_page = nil
    site.page('Bar') {|page| the_page = page }
    the_page.should be_an_instance_of(BarPage)
  end

  it "should accept a browser instance" do
    browser = stub_browser
    foo = Foo.new(:browser => browser)
    foo.browser.should eql(browser)
  end

  it "should create a browser instance if one is not provided" do
    browser = stub_browser
    Taza::Browser.stubs(:create).returns(browser)
    foo = Foo.new
    foo.browser.should eql(browser)
  end

  it "should still close browser if an error is raised" do
    browser = stub_browser
    browser.expects(:close)
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new { |site| raise StandardError}}.should raise_error
  end

  it "should not close browser if block not given" do
    browser = stub
    browser.stubs(:goto)
    browser.expects(:close).never
    Taza::Browser.stubs(:create).returns(browser)
    Foo.new
  end

  it "should not close browser if an error is raised on browser goto" do
    browser = Object.new
    browser.stubs(:goto).raises(StandardError,"ErrorOnBrowserGoto")
    browser.expects(:close).never
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new }.should raise_error(StandardError,"ErrorOnBrowserGoto")
  end

  it "should raise browser close error if no other errors" do
    browser = stub_browser
    browser.expects(:close).raises(StandardError,"BrowserCloseError")
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new {}}.should raise_error(StandardError,"BrowserCloseError")
  end

  it "should raise error inside block if both it and browser.close throws an error" do
    browser = stub_browser
    browser.expects(:close).raises(StandardError,"BrowserCloseError")
    Taza::Browser.stubs(:create).returns(browser)
    lambda { Foo.new { |site| raise StandardError, "innererror" }}.should raise_error(StandardError,"innererror")
  end

  it "should close a browser if block given" do
    browser = stub_browser
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
    klass.any_instance.stubs(:pages_path).returns(@pages_path)
    klass.new do |site|
      site.should respond_to(:bar_page)
    end
  end

  it "should yield after browser has been setup" do
    Taza::Browser.stubs(:create).returns(stub_browser)
    klass = Class::new(Taza::Site)
    klass.any_instance.stubs(:pages_path).returns(@pages_path)
    klass.new do |site|
      site.browser.should_not be_nil
    end
  end

  it "should pass its browser instance to its pages " do
    browser = stub_browser
    Taza::Browser.stubs(:create).returns(browser)
    foo = Foo.new
    foo.bar_page.browser.should eql(browser)
  end

  it "should add partials defined under the pages directory" do
    Taza::Browser.stubs(:create).returns(stub_browser)
    klass = Class::new(Taza::Site)
    klass.any_instance.stubs(:pages_path).returns(@pages_path)
    klass.new do |site|
      site.partial_the_reckoning
    end
  end

  it "should have a way to evaluate a block of code before site closes the browser" do
    browser = stub()
    browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(browser)
    browser_state = states('browser_open_state').starts_as('on')
    browser.expects(:close).then(browser_state.is('off'))
    browser.expects(:doit).when(browser_state.is('on'))
    Taza::Site.before_browser_closes { |browser| browser.doit }
    Foo.new {}
  end

  it "should have a way to evaluate a block of code before site closes the browser if an error occurs" do
    browser = stub()
    browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(browser)
    browser_state = states('browser_open_state').starts_as('on')
    browser.expects(:close).then(browser_state.is('off'))
    browser.expects(:doit).when(browser_state.is('on'))
    Taza::Site.before_browser_closes { |browser| browser.doit }
    lambda { Foo.new { |site| raise StandardError, "innererror" }}.should raise_error(StandardError,"innererror")
  end

  it "should still close its browser if #before_browser_closes raises an exception" do
    browser = stub()
    browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(browser)
    browser.expects(:close)
    Taza::Site.before_browser_closes { |browser| raise StandardError, 'foo error' }
    lambda { Foo.new {} }.should raise_error(StandardError,'foo error')
  end

  it "should not close a browser it did not make" do
    browser = stub()
    browser.stubs(:goto)
    browser.expects(:close).never
    Foo.new(:browser => browser) {}
  end

  it "should close a browser it did make" do
    browser = stub()
    Taza::Browser.stubs(:create).returns(browser)
    browser.stubs(:goto)
    browser.expects(:close)
    Foo.new() {}
  end
    
  module Zoro
    class Zoro < ::Taza::Site
    end
  end
    
  it "should pass in the class name to settings config" do
    browser = stub()
    browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(browser)
    Taza::Settings.expects(:config).with('Zoro').returns({}).at_least_once
    Zoro::Zoro.new
  end

  it "should return the configured site url" do
    Taza::Settings.expects(:environment_settings).returns({:url => 'http://www.zoro.com'}).at_least_once
    Zoro::Zoro.new(:browser => stub_browser).url.should == 'http://www.zoro.com'
  end
  
  it "should go to a relative url" do
    browser = stub_browser
    browser.expects(:goto).with('http://www.foo.com/page.html')
    Taza::Browser.stubs(:create).returns(browser)
    Taza::Settings.stubs(:config).returns(:url => 'http://www.foo.com')
    Foo.new.goto 'page.html'
  end
  
  it "should go to the default url" do
    browser = stub_browser
    browser.expects(:goto).with('http://www.foo.com')
    Taza::Browser.stubs(:create).returns(browser)
    Taza::Settings.stubs(:config).returns(:url => 'http://www.foo.com')
    Foo.new.goto
  end
    
  def stub_browser
    browser = stub()
    browser.stubs(:close)
    browser.stubs(:goto)
    browser
  end
  
end
