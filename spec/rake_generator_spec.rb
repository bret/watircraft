require 'rubygems'
require 'rake'
require 'need'
require 'fileutils'
need { 'spec_helper' }
need { '../lib/generators/rake_generator' }

describe RakeGenerator do
  
  before :all do
    @path = "spec"
    @file_name = "./spec/rakefile"
  end

  after :each do
    FileUtils.rm_f(@file_name)
  end

  it "should generate a rake file at a given path" do
    generator = RakeGenerator.new(@path)
    generator.generate
    File.exists?(@file_name).should be_true
  end

end
