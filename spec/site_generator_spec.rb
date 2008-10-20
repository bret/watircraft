require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe Taza::Generators::Site do

  before :all do
    @project_folder = File.join('spec','example')
    @site_name = "WikipediaFoo"
    @site_file = File.join(@project_folder,'lib','sites' , "wikipedia_foo.rb")
    @site_folder = File.join(@project_folder,'lib','sites' , "wikipedia_foo")
  end

  before :each do
    Taza::Generators::Project.new(@project_folder).generate
  end
  
  after :each do
    FileUtils.rm_rf(@project_folder)
  end

  it "should generate a site file" do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Site.new(@site_name)
    generator.generate
    File.exists?(@site_file).should be_true
  end
  
  it "should generate configuration file for a site" do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Site.new(@site_name)
    generator.generate
    File.exists?(File.join(@project_folder,'config','wikipedia_foo.yml')).should be_true
  end

  it "should generate a site path for pages" do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Site.new(@site_name)
    generator.generate
    File.directory?(@site_folder).should be_true
  end

  it "should generate a folder for a sites functional tests" do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Site.new(@site_name)
    generator.generate
    File.directory?(File.join(@project_folder,'spec','functional','wikipedia_foo')).should be_true
  end

  it "should generate a file that can be required" do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Site.new(@site_name)
    generator.generate
    system("ruby -c #{@site_file} > #{null_device}").should be_true
  end

  it "should generate a file in lib sites" do
    generator = Taza::Generators::Site.new(@site_name)
    generator.folder_path.should eql('.')
  end
  
end