require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

describe Taza::Generators::Page do
  include RubiGen::GeneratorTestHelper
  
  before :all do
    @site_name = "Gap"
    @site_folder = File.join(PROJECT_FOLDER,'lib','sites',"gap")
    @site_file = File.join(PROJECT_FOLDER,'lib','sites',"gap.rb")
    @page_name = "CheckOut"
    @page_file = File.join(PROJECT_FOLDER,'lib','sites', "gap", "pages" , "check_out.rb")
    @page_functional_spec = File.join(PROJECT_FOLDER,'spec','functional','gap','check_out_spec.rb')
  end
  
  before :each do
    bare_setup
    run_generator('taza', [APP_ROOT], sources)
    
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(PROJECT_FOLDER)
    Taza::Generators::Site.new(@site_name).generate
  end

  after :each do
    bare_teardown
  end

  it "should generate a page file in lib/\#{site_name}/pages/" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(PROJECT_FOLDER)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    File.exists?(@page_file).should be_true
  end
  
  it "should generate a functional spec for the generated page" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(PROJECT_FOLDER)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    File.exists?(@page_functional_spec).should be_true
  end
  
  it "should generate a page that can be required" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(PROJECT_FOLDER)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    system("ruby -c #{@page_file} > #{null_device}").should be_true
  end
  
  
  it "should generate a page spec that can be required" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(PROJECT_FOLDER)
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    system("ruby -c #{@page_functional_spec} > #{null_device}").should be_true
  end
  
  it " should have the right folder path generated " do
    generator = Taza::Generators::Page.new("","")
    generator.folder_path.should eql(".")
  end
  
  private
   def sources
     [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", generator_path))]
   end

   def generator_path
     "app_generators"
   end
end
