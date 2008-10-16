require 'rubygems'
require 'spec/spec_helper'
require 'taza'

describe Taza::Settings do
  before :each do
    ENV['browser'] = nil
    ENV['driver'] = nil
  end

  it "should use environment variable for browser settings" do
    Taza::Settings.stubs(:config_file).returns({})
    ENV['browser'] = 'foo'
    Taza::Settings.config[:browser].should eql(:foo)
  end
  
  it "should provide default values if no config file or environment settings provided" do
    Taza::Settings.stubs(:config_file).returns({})
    Taza::Settings.config[:driver].should eql(:selenium)
    Taza::Settings.config[:browser].should eql(:firefox)
  end
  
  it "should use environment variable for driver settings" do
    Taza::Settings.stubs(:config_file).returns({})
    ENV['driver'] = 'bar'
    Taza::Settings.config[:driver].should eql(:bar)
  end

  it "should use the config file's variable for browser settings if no environment variable is set" do
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.config[:browser].should eql(:fu)
  end

  it "should use the ENV variables if specfied instead of config files" do
    ENV['browser'] = 'opera'
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.config[:browser].should eql(:opera)
  end

  it "should use the correct config file to set defaults" do
    Taza::Settings.stubs(:path).returns('spec/sandbox/config.yml')
    Taza::Settings.config[:browser].should eql(:default_browser)
    Taza::Settings.config[:driver].should eql(:default_driver)
  end
  
  it "should raise error for a config file that doesnot exist" do
    Taza::Settings.stubs(:path).returns('spec/sandbox/file_not_exists.yml')
    lambda {Taza::Settings.config}.should raise_error
  end
  
  it "should path point at config file" do
    Taza::Settings.path.should eql('config/config.yml')
  end
  
  it "should use the config file's variable for driver settings if no environment variable is set" do
    Taza::Settings.stubs(:config_file).returns({:driver => :fun})
    Taza::Settings.config[:driver].should eql(:fun)    
  end

end
