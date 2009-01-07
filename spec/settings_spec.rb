require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe Taza::Settings do
  
  before :each do
    ENV['TAZA_ENV'] = 'isolation'
    ENV['BROWSER'] = nil
    ENV['DRIVER'] = nil
  end

  it "should use environment variable for browser settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    ENV['BROWSER'] = 'foo'
    Taza::Settings.config('SiteName')[:browser].should eql(:foo)
  end

  it "should use environment variable for driver settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    ENV['DRIVER'] = 'bar'
    Taza::Settings.config('SiteName')[:driver].should eql(:bar)
  end
  
  it "should provide default values if no config file or environment settings provided" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config('SiteName')[:driver].should eql(:selenium)
    Taza::Settings.config('SiteName')[:browser].should eql(:firefox)
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
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.config('SiteName')[:browser].should eql(:fu)
  end

  it "should use the config file's variable for driver settings if no environment variable is set" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.stubs(:config_file).returns({:driver => :fun})
    Taza::Settings.config('SiteName')[:driver].should eql(:fun)    
  end

  it "should use the ENV variables if specified instead of config files" do
    ENV['BROWSER'] = 'opera'
    Taza::Settings.expects(:config_file).returns({:browser => :fu})
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config('SiteName')[:browser].should eql(:opera)
  end

  it "should use the correct config file" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.stubs(:config_file_path).returns('spec/sandbox/config.yml')
  end
  
  it "should raise error when the config file does not exist" do
    Taza::Settings.stubs(:path).returns('spec/no_such_directory')
    lambda {Taza::Settings.config}.should raise_error
  end
  
  it "should base the path at the root directory" do
    Taza::Settings.path.should eql('.')
  end
  
  class SiteName < Taza::Site
  end

  it "a site should be able to load its settings" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    SiteName.settings[:url].should eql('http://google.com')
  end

  it "setting keys can be specified as strings (i.e. without a colon) in the config file" do
    Taza::Settings.stubs(:config_file_path).returns("spec/sandbox/config/simpler.yml")
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config('SiteName')[:browser].should eql(:opera)
  end
  
  it "setting keys can be specified as strings (i.e. without a colon) in the config file" do
    Taza::Settings.stubs(:path).returns("spec/sandbox")
    Taza::Settings.config('SimplerSite')[:url].should eql('http://makezine.com')
  end

  it "should be able to convert string keys to symbol keys" do
    result = Taza::Settings.convert_string_keys_to_symbols 'browser' => :foo
    result.should == {:browser => :foo}
  end

end
