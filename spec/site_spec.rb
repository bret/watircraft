require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe 'Site Spec' do
  
  module ::Foo
    class Foo < ::Taza::Site
      
    end
  end
  
  before :all do
    @pages_path = File.join("spec","sandbox","pages","foo","**","*.rb")
    @flows_path = File.join("spec","sandbox","flows","*.rb")
    @methods_path = File.join("spec","sandbox","methods","*.rb")
    @foo_class = ::Foo::Foo
  end

  before :each do
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil

    @foo_class.any_instance.stubs(:pages_path).returns(@pages_path)
    @foo_class.any_instance.stubs(:methods_path).returns(@methods_path)
    Taza::Settings.stubs(:config_file).returns({})
    Taza::Settings.stubs(:environment_settings).returns({})
    Taza::Site.before_browser_closes {}
    @browser = stub_browser
    Taza::Browser.stubs(:create).returns(@browser)

    @site = @foo_class.new
  end
        
  def stub_browser
    browser = stub()
    browser.stubs(:close)
    browser.stubs(:goto)
    browser
  end

  shared_examples_for "an execution context" do
    it "should yield an instance of a page class" do
      barzor = nil
      @context.bar_page do |bar|
        barzor = bar
      end
      barzor.should be_an_instance_of(Foo::BarPage)
    end
    
    it "should return a page by name" do
      # Bar is a page on the site
      @context.bar_page.should be_an_instance_of(Foo::BarPage)
    end
    
    it "should return a page by method" do
      @context.page('bar').should be_an_instance_of(Foo::BarPage)
      @context.page('Bar').should be_an_instance_of(Foo::BarPage)
    end
    
    it "should yield to a page" do
      the_page = nil
      @context.page('Bar') {|page| the_page = page }
      the_page.should be_an_instance_of(Foo::BarPage)
    end
  
    it "should pass the site browser instance to its pages " do
      @context.bar_page.browser.should eql(@browser)
    end
    
    it "should provide direct access to the site" do
      @context.site.should == @site
    end
    
    it "should all access to the site origin" do
      Taza::Settings.expects(:environment_settings).returns({:url => 'http://www.zoro.com'}).at_least_once
      @context.site.origin.should == 'http://www.zoro.com'
    end
        
    it "should go to a relative url" do
      @browser.expects(:goto).with('http://www.foo.com/page.html')
      Taza::Settings.stubs(:config).returns(:url => 'http://www.foo.com')
      @context.goto 'page.html'
    end
    
    it "should go to the site origin" do
      @browser.expects(:goto).with('http://www.foo.com/')
      Taza::Settings.stubs(:config).returns(:url => 'http://www.foo.com')
      @context.goto ''
    end

    it "should allow pages to access the site" do
      @context.bar_page.site.should == @site
    end
    
    it "should list the site's pages" do
      @context.pages.should == ["bar_page", "partial_the_reckoning"]
    end
    
    it "should provide Spec::Matchers" do
      @context.instance_eval { [1,2,3].should include(2) }
    end
    
    it "should load the methods files" do
      defined?(Foo::Methods).should be_true
      Foo::Methods.instance_methods.should include("spiderman")
    end
    
    it "should have user-site-methods defined as instance methods" do
      @context.spiderman.should == 'i am spiderman'
    end
  end
    
  describe Taza::Site do
    it_should_behave_like "an execution context"
    
    before :each do
      @context = @site
    end
    
    it "pages_path should not contain the site class name" do
      Bax = Class.new(Taza::Site)
      Bax.new.send(:pages_path).should eql(APP_ROOT + "/lib/pages/**/*.rb")
    end
    
    it "should have flows defined as instance methods" do
      Barz = Class.new(Taza::Site)
      Barz.any_instance.stubs(:path).returns('spec/sandbox')
      Barz.any_instance.stubs(:flows_path).returns(@flows_path)
      Barz.new.batman_flow.should == "i am batman"
    end
    
    it "should open watir browsers at the configuration URL" do
      @browser.expects(:goto).with('a_url')
      Taza::Settings.stubs(:config).returns(:url => 'a_url')
      @foo_class.new
    end
        
    it "should accept a browser instance" do
      provided_browser = stub_browser
      site = @foo_class.new(:browser => provided_browser)
      site.browser.should eql(provided_browser)
    end
    
    it "should create a browser instance if one is not provided" do
      site = @foo_class.new
      site.browser.should eql(@browser)
    end
    
    it "should still close browser if an error is raised" do
      @browser.expects(:close)
      lambda { @foo_class.new { |site| raise StandardError}}.should raise_error
    end
    
    it "should not close browser if block not given" do
      @browser.expects(:close).never
      @foo_class.new
    end
    
    it "should not close browser if an error is raised on browser goto" do
      @browser.stubs(:goto).raises(StandardError,"ErrorOnBrowserGoto")
      @browser.expects(:close).never
      lambda { @foo_class.new }.should raise_error(StandardError,"ErrorOnBrowserGoto")
    end
    
    it "should raise browser close error if no other errors" do
      @browser.expects(:close).raises(StandardError,"BrowserCloseError")
      lambda { @foo_class.new {}}.should raise_error(StandardError,"BrowserCloseError")
    end
    
    it "should raise error inside block if both it and browser.close throws an error" do
      @browser.expects(:close).raises(StandardError,"BrowserCloseError")
      lambda { @foo_class.new { |site| raise StandardError, "innererror" }}.should raise_error(StandardError,"innererror")
    end
    
    it "should close a browser if block given (and it did not make it)" do
      @browser.expects(:close)
      @foo_class.new {}
    end
    
    it "should yield itself upon initialization" do
      foo = nil
      f = @foo_class.new { |site| foo = site }
      foo.should eql(f)
    end
    
    it "should yield after page methods have been setup" do
      klass = Class::new(Taza::Site)
      klass.any_instance.stubs(:pages_path).returns(@pages_path)
      klass.new do |site|
        site.should respond_to(:bar_page)
      end
    end
    
    it "should yield after browser has been setup" do
      klass = Class::new(Taza::Site)
      klass.any_instance.stubs(:pages_path).returns(@pages_path)
      klass.new do |site|
        site.browser.should_not be_nil
      end
    end
    
    it "should add partials defined under the pages directory" do
      klass = Class::new(Taza::Site)
      klass.any_instance.stubs(:pages_path).returns(@pages_path)
      klass.new do |site|
        site.partial_the_reckoning
      end
    end
    
    it "should have a way to evaluate a block of code before site closes the browser" do
      browser_state = states('browser_open_state').starts_as('on')
      @browser.expects(:close).then(browser_state.is('off'))
      @browser.expects(:doit).when(browser_state.is('on'))
      Taza::Site.before_browser_closes { |browser| browser.doit }
      @foo_class.new {}
    end
    
    it "should have a way to evaluate a block of code before site closes the browser if an error occurs" do
      browser_state = states('browser_open_state').starts_as('on')
      @browser.expects(:close).then(browser_state.is('off'))
      @browser.expects(:doit).when(browser_state.is('on'))
      Taza::Site.before_browser_closes { |browser| browser.doit }
      lambda { @foo_class.new { |site| raise StandardError, "innererror" }}.should raise_error(StandardError,"innererror")
    end
    
    it "should still close its browser if #before_browser_closes raises an exception" do
      @browser.expects(:close)
      Taza::Site.before_browser_closes { |browser| raise StandardError, 'foo error' }
      lambda { @foo_class.new {} }.should raise_error(StandardError,'foo error')
    end
    
    it "should not close a browser it did not make" do
      @browser.expects(:close).never
      @foo_class.new(:browser => @browser) {}
    end
    
    module Zoro
      class Zoro < ::Taza::Site
      end
    end
    
    it "should pass in the class name to settings config" do
      Taza::Settings.expects(:config).with('Zoro').returns({}).at_least_once
      Zoro::Zoro.new
    end
    
    it "should return the configured site url" do
      Taza::Settings.expects(:environment_settings).returns({:url => 'http://www.zoro.com'}).at_least_once
      @site.origin.should == 'http://www.zoro.com'
    end

    it "should call the initialize method" do
      
      class SubClass < Taza::Site
        def initialize_browser
          @browser = 'provided'
        end
      end
      
      SubClass.new.browser.should == 'provided'
    end
        
  end
  
  describe "Rspec Context" do
    it_should_behave_like "an execution context"
    before do
      # this code replicates what is in spec_initialize.rb
      @context = Spec::Example::ExampleGroup.new "sample"
      @site.initialize_context!(@context)
    end
    
  end
  
  describe "Site#execution_context (aka irb START)" do
    it_should_behave_like "an execution context"
    before do
      @context = @site.execution_context
    end
  end
  
end
