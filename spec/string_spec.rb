require 'spec/spec_helper'
require 'extensions/string'

describe "string extensions" do
  it "should pluralize and to sym a string" do
    "apple".pluralize_to_sym.should eql(:apples)
  end
  it "should computerize a string with a space" do
    "count down".computerize.should == "count_down"
  end
  it "should computerize a string that is capitalized" do
    "Count Down".computerize.should == "count_down"
  end
  it "should computerize a string that is in CamelCase" do
    "CountDown".computerize.should == "count_down"
  end
end
