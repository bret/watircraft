require 'rubygems'
require 'fileutils'
require 'taza/generators'
require 'spec/spec_helper'

describe "Taza project generator script" do

  after :each do
    FileUtils.rm_rf('spec/sandbox')
  end

  it "should have an executable script" do
    path = 'spec/sandbox'
    taza_bin = "#{File.expand_path(File.dirname(__FILE__)+'/../bin/taza')} #{path}"
    system("#{taza_bin}").should be_true
  end

  it "should have a windows version (a bat file)"

  it "should create a folder for the project skeleton" do 
    path = 'spec/sandbox'
    taza_bin = "#{File.expand_path(File.dirname(__FILE__)+'/../bin/taza')} #{path}"
    system("#{taza_bin}")
    File.directory?(path).should be_true
  end

end
