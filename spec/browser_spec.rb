require 'spec/spec_helper'
require 'taza/browser'
require 'taza/settings'
require 'selenium'
require 'watir'

describe Taza::Browser do

  before :each do
    reset_env_vars
    Taza::Settings.stubs(:config_file).returns({})
    ENV['ENVIRONMENT'] = 'test'
  end

  after :all do
    reset_env_vars
  end
  def reset_env_vars
    ENV['ENVIRONMENT'] = nil
    ENV['SERVER_PORT'] = nil
    ENV['SERVER_IP'] = nil
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
    ENV['TIMEOUT'] = nil
  end

  it "should raise unknown browser error for unsupported watir browsers" do
    lambda { Taza::Browser.create(:browser => 'foo_browser_9000', :driver => 'watir') }.should raise_error(StandardError)
  end

  it "should use params browser type when creating selenium" do
    browser_type = 'opera'
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,'*opera',anything)
    Taza::Browser.create(:browser => browser_type, :driver => 'selenium')
  end

  it "should raise selenium unsupported browser error" do
    Taza::Browser.create(:browser => 'foo', :driver => 'selenium')
  end

  it "should be able to create a selenium instance" do
    browser = Taza::Browser.create(:browser => 'firefox', :driver => 'selenium')
    browser.should be_a_kind_of(Selenium::SeleniumDriver)
  end

  it "should use environment settings for server port and ip" do
    Taza::Settings.stubs(:path).returns(File.join('spec','sandbox'))
    ENV['SERVER_PORT'] = 'server_port'
    ENV['SERVER_IP'] = 'server_ip'
    ENV['DRIVER'] = 'selenium'
    Selenium::SeleniumDriver.expects(:new).with('server_ip','server_port',anything,anything)
    Taza::Browser.create(Taza::Settings.config("SiteName"))
  end

  it "should use environment settings for timeout" do
    Taza::Settings.stubs(:path).returns(File.join('spec','sandbox'))
    ENV['TIMEOUT'] = 'timeout'
    ENV['DRIVER'] = 'selenium'
    Selenium::SeleniumDriver.expects(:new).with(anything,anything,anything,'timeout')
    Taza::Browser.create(Taza::Settings.config("SiteName"))
  end

  # a test of a stub for testing the test harness of our tests
  it "should provide a fake browser, so we can test our test harness" do
    Taza::Browser.create(:driver => 'fake').should be_a(Taza::FakeBrowser)
  end
  
end
