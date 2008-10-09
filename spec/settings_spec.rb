require 'rubygems'
require 'spec/spec_helper'
require 'taza'

describe Taza::Settings do
  it "should use environment variable for browser settings" do
    ENV['browser'] = 'foo'
    Taza::Settings.browser[:browser].should eql(:foo)
  end
  
  it "should use environment variable for driver settings"
end
