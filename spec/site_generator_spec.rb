require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

describe Taza::Generators::Site do
  include RubiGen::GeneratorTestHelper

  before :all do
    @spec_helper = File.join(TMP_ROOT,PROJECT_NAME,'spec','spec_helper.rb')
    @site_name = "WikipediaFoo"
    @site_file = File.join(PROJECT_FOLDER,'lib','sites' , "wikipedia_foo.rb")
    @site_folder = File.join(PROJECT_FOLDER,'lib','sites' , "wikipedia_foo")
  end

  before :each do
    bare_setup
    run_generator('taza', [APP_ROOT], sources)
  end

  after :each do
    bare_teardown
  end

  it "should generate a site file" do
    run_generator('site', [@site_name], sources)
    File.exists?(@site_file).should be_true
  end

  it "should generate configuration file for a site" do
    run_generator('site', [@site_name], sources)
    File.exists?(File.join(PROJECT_FOLDER,'config','wikipedia_foo.yml')).should be_true
  end

  it "should generate a site path for pages" do
    run_generator('site', [@site_name], sources)
    File.directory?(@site_folder).should be_true
  end

  it "should generate a folder for a sites functional tests" do
    run_generator('site', [@site_name], sources)
    File.directory?(File.join(PROJECT_FOLDER,'spec','functional','wikipedia_foo')).should be_true
  end

  it "should generate a file that can be required" do
    run_generator('site', [@site_name], sources)
    system("ruby -c #{@site_file} > #{null_device}").should be_true
  end
  private
  def sources
    [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "app_generators")),
    RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "generators"))]
  end

end
