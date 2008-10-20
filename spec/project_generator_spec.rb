require 'spec/spec_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza/generators'

describe Taza::Generators::Project do

  before :all do
    @path = File.join('.','spec','sandbox','generated')
    @rake_file = File.join(@path,'rakefile')
    @spec_helper = File.join(@path,'spec','spec_helper.rb')
  end

  after :each do
    FileUtils.rm_rf(@path)
  end

  it "should generate a rake file at a given path" do
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    File.exists?(@rake_file).should be_true
  end
  
  it "should generate a page that can be required" do
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end
  
  it "spec helper should set the TAZA_ENV variable if it is not provided" do
    ENV['TAZA_ENV'] = nil
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    load @spec_helper
    ENV['TAZA_ENV'].should eql("isolation")
  end

  it "spec helper should not override the TAZA_ENV variable if was provided" do
    ENV['TAZA_ENV'] = 'orange pie? is there such a thing?'
    generator = Taza::Generators::Project.new(@path)
    generator.generate
    load @spec_helper
    ENV['TAZA_ENV'].should eql('orange pie? is there such a thing?')
  end
end