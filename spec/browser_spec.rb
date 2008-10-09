require 'spec/spec_helper'
require 'taza/browser'

describe Taza::Browser do
  
  before :each do
    ENV['browser'] = nil
    ENV['driver'] = nil
  end
  
  it "should be able to create a watir driver" do
    Taza::Browser.expects(:create_watir)
    ENV['driver'] = 'watir'
    Taza::Browser.create
  end
  
  it "should be able to create a firewatir driver" do
    Taza::Browser.expects(:create_firewatir)
    ENV['driver'] = 'firewatir'
    Taza::Browser.create
  end
  
  it "should use selenium as the default driver" do
    browser_type = '*firefox'
    Taza::Browser.expects(:create_selenium).with(browser_type)
    ENV['browser'] = browser_type
    Taza::Browser.create
  end

  it "should default to selenium as the default driver"  
  it "should get browser type from the config"
  it "should override config with environment setting"
  it "should default to a kind of browser"
  it "should validate allowed browsers"
end