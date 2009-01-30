require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe "WatirCraft project generator script" do

  it "should have an executable script" do
    path = 'spec/sandbox/generators'
    taza_bin = "#{File.expand_path(File.dirname(__FILE__)+'/../bin/watircraft')} #{path}"
    system("ruby -c #{taza_bin} > #{null_device}").should be_true
  end

end
