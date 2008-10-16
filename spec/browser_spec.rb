require 'spec/spec_helper'
require 'taza/browser'
require 'selenium'
require 'firewatir'

describe Taza::Browser do

  before :each do
     Taza::Settings.stubs(:config_file).returns({})    
  end
  
  after :each do
    ENV['server_port'] = nil
    ENV['server_ip'] = nil
    ENV['browser'] = nil
    ENV['driver'] = nil
    ENV['timeout'] = nil
  end

  it "should be able to create a watir driver" do
    Taza::Browser.expects(:create_watir_ie)
    Taza::Browser.create(:browser => :ie, :driver => :watir)
  end

  it "should be able to create a firewatir driver" do
    Taza::Browser.expects(:create_watir_firefox)
    Taza::Browser.create(:browser => :firefox,:driver => :watir)
  end

  it "should be able to create a safariwatir driver" do
    Taza::Browser.expects(:create_watir_safari)
    Taza::Browser.create(:browser => :safari,:driver => :watir)
  end

  it "should raise unknown browser error for unsupported watir browsers" do
    lambda { Taza::Browser.create(:browser => :foo_browser_9000,:driver => :watir) }.should raise_error(BrowserUnsupportedError)
  end

  it "should use params browser type when creating selenium" do
    browser_type = :opera
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,'*opera',anything)
    Taza::Browser.create(Taza::Settings.config.merge(:browser => browser_type))
  end

  it "should default to firefox on selenium" do
    Taza::Browser.expects(:create_selenium).with({:browser => :firefox,:driver  => :selenium})
    Taza::Browser.create(Taza::Settings.config)
  end
  
  it "should raise selenium unsupported browser error" do 
    Taza::Browser.create(:browser => :foo, :driver => :selenium)
  end

  it "should be able to create a selenium instance" do
    browser = Taza::Browser.create(:browser => :firefox, :driver => :selenium)
    browser.should be_a_kind_of(Selenium::SeleniumDriver)
  end
  
  it "should use environment settings for server port and ip" do
    ENV['server_port'] = 'server_port'
    ENV['server_ip'] = 'server_ip'
    Selenium::SeleniumDriver.expects(:new).with('server_ip','server_port',anything,anything)
    Taza::Browser.create(Taza::Settings.config)
  end
  
  it "should use environment settings for timeout" do
    ENV['timeout'] = 'timeout'
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,anything,'timeout')
    Taza::Browser.create(Taza::Settings.config)
  end
  
  it "should create firewatir instance" do
    ENV['browser'] = 'firefox'
    ENV['driver'] = 'watir'
    FireWatir::Firefox.expects(:new)
    Taza::Browser.create(Taza::Settings.config)
  end
end