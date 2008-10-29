require 'spec/spec_helper'
require 'taza/browser'

describe "Taza::Browser with watir ie" do
  it "should be able to make watir ie instance" do
    browser = nil
    begin 
      browser =  Taza::Browser.create({:browser => :ie,:driver =>:watir,:url => 'http://www.google.com'})
      browser.should be_a_kind_of(Watir::IE)
    ensure
      browser.close if browser.respond_to?(:close)
    end
  end  
end