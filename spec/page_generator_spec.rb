require 'rubygems'
require 'need'
require 'fileutils'
need { 'spec_helper' }
need { '../lib/generators/page_generator' }
need { '../lib/generators/site_generator' }

describe PageGenerator do
  
  before :all do
    @site_name = "Gap"
    @site_folder = File.join("spec","gap")
    @site_file = File.join("spec","gap.rb")
    @page_name = "CheckOut"
    @page_file = File.join("spec", "gap", "pages" , "check_out.rb")
  end
  
  before :each do
    SiteGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    SiteGenerator.new(@site_name).generate
  end
    
  after :each do
    FileUtils.rm_rf(@site_folder)
    FileUtils.rm_rf(@site_file)
  end

  it "should generate a page file in lib/\#{site_name}/pages/" do
    PageGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = PageGenerator.new(@page_name,@site_name)
    generator.generate
    File.exists?(@page_file).should be_true
  end
  
  it "should generate a file that can be required" do
    PageGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = PageGenerator.new(@page_name,@site_name)
    generator.generate
    system("ruby -c #{@page_file} > /dev/null").should be_true
  end
  
  
  it " should have the right folder path generated " do
    generator = PageGenerator.new("","")
    generator.folder_path.should eql("lib/sites")
  end
end
