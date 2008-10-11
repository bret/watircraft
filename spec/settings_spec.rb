require 'rubygems'
require 'spec/spec_helper'
require 'taza'

describe Taza::Settings do
  before :each do
    ENV['browser'] = nil
    ENV['driver'] = nil
  end

  it "should use environment variable for browser settings" do
    Taza::Settings.stubs(:defaults).returns({})
    ENV['browser'] = 'foo'
    Taza::Settings.browser[:browser].should eql(:foo)
  end
  
  it "should use environment variable for driver settings" do
    Taza::Settings.stubs(:defaults).returns({})
    ENV['driver'] = 'bar'
    Taza::Settings.browser[:driver].should eql(:bar)
  end

  it "should use the config file's variable for browser settings if no environment variable is set" do
    Taza::Settings.expects(:defaults).returns({:browser => :fu})
    Taza::Settings.browser[:browser].should eql(:fu)
  end

  it "should use the ENV variables if specfied instead of config files" do
    ENV['browser'] = 'opera'
    Taza::Settings.expects(:defaults).returns({:browser => :fu})
    Taza::Settings.browser[:browser].should eql(:opera)
  end

  it "should use the correct config file to set defaults" do
    Taza::Settings.stubs(:path).returns('spec/sandbox/config.yml')
    Taza::Settings.browser[:browser].should eql(:default_browser)
    Taza::Settings.browser[:driver].should eql(:default_driver)
  end
  
  it "should raise error for a config file that doesnot exist" do
    Taza::Settings.stubs(:path).returns('spec/sandbox/file_not_exists.yml')
    lambda {Taza::Settings.browser}.should raise_error
  end
  
  it "should path point at config file" do
    Taza::Settings.path.should eql('config/config.yml')
  end
  it "should use the config file's variable for driver settings if no environment variable is set"

end
