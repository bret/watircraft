require 'spec/spec_helper'
require 'taza/browser'

describe Taza::Browser do
  
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
  it "should raise selenium unsupported browser error"
end