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

end
