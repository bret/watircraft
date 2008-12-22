require 'spec/spec_helper'
require 'taza/browser'
require 'taza/settings'
require 'selenium'

describe Taza::Browser do

  before :each do
    Taza::Settings.stubs(:config_file).returns({})
    ENV['TAZA_ENV'] = 'isolation'
    ENV['SERVER_PORT'] = nil
    ENV['SERVER_IP'] = nil
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
    ENV['TIMEOUT'] = nil
  end

  module Watir
    class Safari
    end
  end

  describe "Taza::Browser with Safari Watir" do
    it "should be able to make a safari watir instance" do
      Taza::Browser.expects(:require).with('safariwatir')
      browser = Taza::Browser.create({:browser => :safari, :driver => :watir,:url =>'http://www.google.com'})
      browser.should be_a_kind_of(Watir::Safari)
    end
  end

  module Watir
    class IE
    end
  end

  describe "Taza::Browser with watir ie" do
    it "should be able to make watir ie instance" do
      Taza::Browser.expects(:require).with('watir')
      browser =  Taza::Browser.create({:browser => :ie,:driver =>:watir,:url => 'http://www.google.com'})
      browser.should be_a_kind_of(Watir::IE)
    end
  end

  it "should be able to create a watir driver" do
    Taza::Browser.expects(:watir_ie).returns(Object)
    Taza::Browser.create(:browser => :ie, :driver => :watir)
  end

  it "should be able to create a firewatir driver" do
    Taza::Browser.expects(:watir_firefox).returns(Object)
    Taza::Browser.create(:browser => :firefox,:driver => :watir)
  end

  it "should be able to create a safariwatir driver" do
    Taza::Browser.expects(:watir_safari).returns(Object)
    Taza::Browser.create(:browser => :safari,:driver => :watir)
  end

  it "should raise unknown browser error for unsupported watir browsers" do
    lambda { Taza::Browser.create(:browser => :foo_browser_9000,:driver => :watir) }.should raise_error(Taza::BrowserUnsupportedError)
  end

  it "should use params browser type when creating selenium" do
    browser_type = :opera
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,'*opera',anything)
    Taza::Browser.create(:browser => browser_type, :driver => :selenium)
  end

  it "should raise selenium unsupported browser error" do
    Taza::Browser.create(:browser => :foo, :driver => :selenium)
  end

  it "should be able to create a selenium instance" do
    browser = Taza::Browser.create(:browser => :firefox, :driver => :selenium)
    browser.should be_a_kind_of(Selenium::SeleniumDriver)
  end

  it "should use environment settings for server port and ip" do
    Taza::Settings.stubs(:path).returns(File.join('spec','sandbox'))
    ENV['SERVER_PORT'] = 'server_port'
    ENV['SERVER_IP'] = 'server_ip'
    Selenium::SeleniumDriver.expects(:new).with('server_ip','server_port',anything,anything)
    Taza::Browser.create(Taza::Settings.config("SiteName"))
  end

  it "should use environment settings for timeout" do
    Taza::Settings.stubs(:path).returns(File.join('spec','sandbox'))
    ENV['TIMEOUT'] = 'timeout'
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,anything,'timeout')
    Taza::Browser.create(Taza::Settings.config("SiteName"))
  end

  it "should be able to give you the class of browser" do
    Taza::Browser.expects(:watir_safari).returns(Object)
    Taza::Browser.browser_class(:browser => :safari, :driver => :watir).should eql(Object) 
  end
  
end
