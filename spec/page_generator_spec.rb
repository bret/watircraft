require 'rubygems'
require 'need'
require 'fileutils'
need { 'spec_helper' }
require 'taza/generators'

describe Taza::Generators::Page do
  
  before :all do
    @site_name = "Gap"
    @site_folder = File.join("spec","gap")
    @site_file = File.join("spec","gap.rb")
    @page_name = "CheckOut"
    @page_file = File.join("spec", "gap", "pages" , "check_out.rb")
  end
  
  before :each do
    Taza::Generators::Site.any_instance.stubs(:folder_path).returns(File.join("spec"))
    Taza::Generators::Site.new(@site_name).generate
  end
    
  after :each do
    FileUtils.rm_rf(@site_folder)
    FileUtils.rm_rf(@site_file)
  end

  it "should generate a page file in lib/\#{site_name}/pages/" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    File.exists?(@page_file).should be_true
  end
  
  it "should generate a file that can be required" do
    Taza::Generators::Page.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = Taza::Generators::Page.new(@page_name,@site_name)
    generator.generate
    system("ruby -c #{@page_file} > /dev/null").should be_true
  end
  
  
  it " should have the right folder path generated " do
    generator = Taza::Generators::Page.new("","")
    generator.folder_path.should eql("lib/sites")
  end
end
