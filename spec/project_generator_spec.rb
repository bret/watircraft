require 'rubygems'
require 'rake'
require 'fileutils'
require 'spec/spec_helper'
require 'taza/generators'

describe Taza::Generators::Project do

  before :all do
    @path = "./spec/sandbox/generated"
    @file_name = "./spec/sandbox/generated/rakefile"
  end

  after :each do
    FileUtils.rm_rf(@path)
  end

  it "should generate a rake file at a given path" do
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    File.exists?(@file_name).should be_true
  end

end
