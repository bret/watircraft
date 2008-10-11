require 'rubygems'
require 'rake'
require 'fileutils'
require 'spec/spec_helper'
require 'taza/generators'

describe Taza::Generators::Project do

  before :all do
    @path = "spec"
    @file_name = "./spec/rakefile"
    Taza::Generators::Project.any_instance.stubs(:folder)
  end

  after :each do
    FileUtils.rm_f(@file_name)
  end

  it "should generate a rake file at a given path" do
    pending do 
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    File.exists?(@file_name).should be_true
    end
  end

end
