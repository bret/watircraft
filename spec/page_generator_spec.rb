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
    @page_file = File.join(PROJECT_FOLDER,'lib','sites', "gap", "pages" , "check_out.rb")
    @page_functional_spec = File.join(PROJECT_FOLDER,'spec','functional','gap','check_out_spec.rb')
  end

  before :each do
    run_generator('taza', [APP_ROOT], sources)
    run_generator('site', [@site_name], sources)
  end

  after :each do
    bare_teardown
  end
  
  it "should generate a page file in lib/\#{site_name}/pages/" do
    run_generator('page', [@page_name,@site_name], sources)
    File.exists?(@page_file).should be_true
  end

  it "should generate a functional spec for the generated page" do
    run_generator('page', [@page_name,@site_name], sources)
    File.exists?(@page_functional_spec).should be_true
  end

  it "should generate a page that can be required" do
    run_generator('page', [@page_name,@site_name], sources)
    system("ruby -c #{@page_file} > #{null_device}").should be_true
  end


  it "should generate a page spec that can be required" do
      run_generator('page', [@page_name,@site_name], sources)
    system("ruby -c #{@page_functional_spec} > #{null_device}").should be_true
  end

  private
  def sources
    [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "app_generators")),
    RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "generators"))]
  end

end
