require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe Taza::Generators::Page do
  
  before :all do
    @project_folder = File.join('spec','example')
    @site_name = "Gap"
    @site_folder = File.join(@project_folder,'lib','sites',"gap")
    @site_file = File.join(@project_folder,'lib','sites',"gap.rb")
    @page_name = "CheckOut"
    @page_file = File.join(@project_folder,'lib','sites', "gap", "pages" , "check_out.rb")
  end
  
  before :each do
    Taza::Generators::Project.new(@project_folder).generate
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(@project_folder)
    Taza::Generators::Site.new(@site_name).generate
  end
    
  after :each do
    FileUtils.rm_rf(@site_folder)
    FileUtils.rm_rf(@site_file)
  end

  it "should generate a page file in lib/\#{site_name}/pages/" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    File.exists?(@page_file).should be_true
  end
  
  it "should generate a file that can be required" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(@project_folder)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    system("ruby -c #{@page_file} > #{null_device}").should be_true
  end
  
  
  it " should have the right folder path generated " do
    generator = Taza::Generators::Page.new("","")
    generator.folder_path.should eql(".")
  end
end
