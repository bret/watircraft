require 'spec/spec_helper'
require 'taza/browser'

describe Taza::Browser do
  
  it "should be able to create a watir driver" do
    Taza::Browser.expects(:create_watir)
    Taza::Browser.create(:driver => :watir)
  end
  
  it "should be able to create a firewatir driver"
  
  it "should use params browser type when creating selenium" do
    browser_type = :opera
    Taza::Browser.expects(:create_selenium).with(browser_type)
    Taza::Browser.create(:browser => browser_type)
  end
  
  it "should default to selenium as the default driver" do
    Taza::Browser.expects(:create_selenium)
    Taza::Browser.create
  end
  
  it "should default to firefox on selenium" do
    Taza::Browser.expects(:create_selenium).with(:firefox)
    Taza::Browser.create
  end
  it "should validate allowed browsers"
end