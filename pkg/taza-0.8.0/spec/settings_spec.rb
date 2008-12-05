require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe Taza::Settings do
  
  before :all do
    @site_name = 'SiteName'
  end
  
  before :each do
    ENV['TAZA_ENV'] = 'isolation'
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
  end

  it "should use environment variable for browser settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    ENV['BROWSER'] = 'foo'
    Taza::Settings.config(@site_name)[:browser].should eql(:foo)
  end
  
  it "should provide default values if no config file or environment settings provided" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config(@site_name)[:driver].should eql(:selenium)
    Taza::Settings.config(@site_name)[:browser].should eql(:firefox)
  end
  
  it "should use environment variable for driver settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    ENV['DRIVER'] = 'bar'
    Taza::Settings.config(@site_name)[:driver].should eql(:bar)
  end
  
  it "should be able to load the site yml" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config("SiteName")[:url].should eql('http://google.com')
  end

  it "should be able to load a alternate site url" do
    ENV['TAZA_ENV'] = 'clown_shoes'
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config("SiteName")[:url].should eql('http://clownshoes.com')
  end

  it "should use the config file's variable for browser settings if no environment variable is set" do
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config(@site_name)[:browser].should eql(:fu)
  end

  it "should use the ENV variables if specfied instead of config files" do
    ENV['BROWSER'] = 'opera'
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config(@site_name)[:browser].should eql(:opera)
  end

  it "should use the correct config file to set defaults" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.stubs(:config_file_path).returns('spec/sandbox/config.yml')
  end
  
  it "should raise error for a config file that doesnot exist" do
    Taza::Settings.stubs(:path).returns('spec/sandbox/file_not_exists.yml')
    lambda {Taza::Settings.config}.should raise_error
  end
  
  it "should path point at root directory" do
    Taza::Settings.path.should eql('.')
  end
  
  it "should use the config file's variable for driver settings if no environment variable is set" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.stubs(:config_file).returns({:driver => :fun})
    Taza::Settings.config(@site_name)[:driver].should eql(:fun)    
  end

  class SiteName < Taza::Site

  end

  it "a site should be able to load its settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    SiteName.settings[:url].should eql('http://google.com')
  end

end
