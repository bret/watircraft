require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

describe "Page Generation" do
  include RubiGen::GeneratorTestHelper

  before :all do
    @site_name = "Gap"
    @site_folder = File.join(PROJECT_FOLDER,'lib','sites',"gap")
    @site_file = File.join(PROJECT_FOLDER,'lib','sites',"gap.rb")
    @page_name = "CheckOut"
    @page_file = File.join(PROJECT_FOLDER,'lib','sites', "gap", "pages" , "check_out_page.rb")
    @page_functional_spec = File.join(PROJECT_FOLDER,'spec','functional','gap','check_out_page_spec.rb')
  end

  before :each do
    run_generator('taza', [APP_ROOT], generator_sources)
    run_generator('site', [@site_name], generator_sources)
  end

  after :each do
    bare_teardown
  end
  
  it "should generate a page file in lib/\#{site_name}/pages/" do
    run_generator('page', [@page_name,@site_name], generator_sources)
    File.exists?(@page_file).should be_true
  end

  it "should give you usage if you do not give two arguments" do
    PageGenerator.any_instance.expects(:usage)
    lambda { run_generator('page', [@page_name], generator_sources) }.should raise_error
  end

  it "should give you usage if you give a site that does not exist" do
    PageGenerator.any_instance.expects(:usage)
    $stderr.expects(:puts).with(regexp_matches(/NoSuchSite/))
    lambda { run_generator('page', [@page_name,"NoSuchSite"], generator_sources) }.should raise_error
  end

  it "should generate a functional spec for the generated page" do
    run_generator('page', [@page_name,@site_name], generator_sources)
    File.exists?(@page_functional_spec).should be_true
  end

  it "should generate a page that can be required" do
    run_generator('page', [@page_name,@site_name], generator_sources)
    system("ruby -c #{@page_file} > #{null_device}").should be_true
  end

  it "should generate a page spec that can be required" do
    run_generator('page', [@page_name,@site_name], generator_sources)
    system("ruby -c #{@page_functional_spec} > #{null_device}").should be_true
  end

  it "should be able to access the generated page from the site" do
    run_generator('page', [@page_name,@site_name], generator_sources)
    require @site_file
    Taza::Settings.expects(:config).returns({})
    stub_browser = stub()
    stub_browser.stubs(:goto)
    Taza::Browser.expects(:create).returns(stub_browser)
    "#{@site_name}::#{@site_name}".constantize.any_instance.expects(:path).returns(@site_folder)
    @site_name.constantize.new.check_out_page
  end

  # LOL this is nub
  it "should be able to access the generated page for its site" do
    new_site_name = "Pag"
    new_site_folder = File.join(PROJECT_FOLDER,'lib','sites',"pag")
    new_site_file = File.join(PROJECT_FOLDER,'lib','sites',"pag.rb")
    new_page_file = File.join(PROJECT_FOLDER,'lib','sites', "pag", "pages" , "check_out_page.rb")
    new_page_functional_spec = File.join(PROJECT_FOLDER,'spec','functional','pag','check_out_page_spec.rb')
    run_generator('site', [new_site_name], generator_sources)
    run_generator('page', [@page_name,@site_name], generator_sources)
    run_generator('page', [@page_name,new_site_name], generator_sources)
    require @site_file
    require new_site_file
    Taza::Settings.stubs(:config).returns({})
    stub_browser = stub()
    stub_browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(stub_browser)
    "#{@site_name}::#{@site_name}".constantize.any_instance.stubs(:path).returns(@site_folder)
    "#{new_site_name}::#{new_site_name}".constantize.any_instance.stubs(:path).returns(new_site_folder)
    @site_name.constantize.new.check_out_page
    Pag.new.check_out_page.class.should_not eql(Gap.new.check_out_page.class)
  end
end
