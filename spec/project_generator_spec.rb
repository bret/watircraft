require 'spec/spec_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper
  
  def project_file relative_path
    File.join(TMP_ROOT, PROJECT_NAME, relative_path)
  end

  before :all do
    @spec_helper = project_file 'test/specs/spec_helper.rb'
  end

  before :each do
    ENV['ENVIRONMENT'] = nil
    bare_setup
  end

  after :each do
    bare_teardown
  end

  def should_be_loadable file, generator_options=nil
    generator_args = [APP_ROOT]
    generator_args << generator_options if generator_options
    run_generator('watircraft', generator_args, generator_sources)
    load_path = File.dirname(__FILE__) + '/../lib'
    system("ruby -I#{load_path} #{file} > #{null_device}").should be_true
  end

  def should_be_loadable_with_cucumber file
    run_generator('watircraft', [APP_ROOT, '--driver=fake'], generator_sources)
    load_path = File.dirname(__FILE__) + '/../lib'
    argv = "[\"#{file}\"]"
    system("ruby -I#{load_path} -e 'require \"cucumber/cli\"; Cucumber::CLI.execute(#{argv})' > #{null_device}").should be_true
  end

  it "should generate a spec helper that can be required even when site name is different" do
    should_be_loadable @spec_helper, '--site=another_name'
  end
  it "should generate a feature helper that can be required" do
    feature_helper = project_file 'test/features/feature_helper.rb'
    should_be_loadable_with_cucumber feature_helper
  end

  it "should generate a rakefile that can be required" do
    rakefile = project_file 'rakefile'
    should_be_loadable rakefile
  end
  
  it "should generate an initializer that can be required" do
    initializer = project_file 'lib/initialize.rb'
    should_be_loadable initializer
  end
  
  it "should be able to update an existing project and figure out the site name" do
    run_generator('watircraft', [APP_ROOT, '--site=crazy'], generator_sources)
    run_generator('watircraft', [APP_ROOT], generator_sources)
    Taza::Settings.config[:site].should == 'crazy'
  end

  # TODO: the following specs are actually testing the initializer

  it "spec helper should set the ENVIRONMENT variable if it is not provided" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    load @spec_helper
    ENV['ENVIRONMENT'].should eql("test")
  end
  
  it "spec helper should not override the ENVIRONMENT variable if was provided" do
    ENV['ENVIRONMENT'] = 'orange pie? is there such a thing?'
    run_generator('watircraft', [APP_ROOT], generator_sources)
    load @spec_helper
    ENV['ENVIRONMENT'].should eql('orange pie? is there such a thing?')
  end
  
  it "should configure a project for watir, implicitly" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:driver].should == :watir
  end

  it "should allow a site name to be specified" do
    run_generator('watircraft', [APP_ROOT, '--site=site_name'], generator_sources)
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:site].should == 'site_name'
  end
  
  it "should allow a browser driver to be specified" do
    run_generator('watircraft', [APP_ROOT, '--driver=nine_iron'], generator_sources)
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:driver].should == :nine_iron
  end

end
