require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza/generators'

describe "Taza project generator script" do

  after :each do
    FileUtils.rm_rf('spec/sandbox/generators')
  end

  it "should have an executable script" do
    path = 'spec/sandbox/generators'
    taza_bin = "#{File.expand_path(File.dirname(__FILE__)+'/../bin/taza')} #{path}"
    system("ruby #{taza_bin}").should be_true
  end

  it "should create a folder for the project skeleton" do 
    path = 'spec/sandbox/generators'
    taza_bin = "#{File.expand_path(File.dirname(__FILE__)+'/../bin/taza')} #{path}"
    system("ruby #{taza_bin}")
    File.directory?(path).should be_true
  end

end
