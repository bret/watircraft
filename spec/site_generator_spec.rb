require 'rubygems'
require 'need'
require 'fileutils'
need { 'spec_helper' }
require 'taza/generators'

describe SiteGenerator do
  
  before :all do
    @site_name = "WikipediaFoo"
    @site_file = File.join("spec" , "wikipedia_foo.rb")
    @site_folder = File.join("spec" , "wikipedia_foo")
  end
    
  after :each do
    FileUtils.rm_f(@site_file)
    FileUtils.rm_rf(@site_folder)
  end

  it "should generate a site file" do
    SiteGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = SiteGenerator.new(@site_name)
    generator.generate
    File.exists?(@site_file).should be_true
  end
  
  it "should generate a site path for pages" do
    SiteGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = SiteGenerator.new(@site_name)
    generator.generate
    File.directory?(@site_folder).should be_true
  end
  
  it "should generate a file that can be required" do
    SiteGenerator.any_instance.stubs(:folder_path).returns(File.join("spec"))
    generator = SiteGenerator.new(@site_name)
    generator.generate
    system("ruby -c #{@site_file} > /dev/null").should be_true
  end

  it "should generate a file in lib sites" do
    generator = SiteGenerator.new(@site_name)
    generator.folder_path.should eql('lib/sites')
  end
end
