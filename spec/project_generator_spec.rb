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
    @feature_helper = project_file 'test/features/feature_helper.rb'
    @rakefile = project_file 'rakefile'
    @initializer = project_file 'lib/initialize.rb'
  end

  before :each do
    ENV['ENVIRONMENT'] = nil
    bare_setup
  end

  after :each do
    bare_teardown
  end

  it "should generate a spec helper that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end

  it "should generate a spec helper that can be required even when site name is different" do
    run_generator('watircraft', [APP_ROOT, '--site=another_name'], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end
  it "should generate a feature helper that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@feature_helper} > #{null_device}").should be_true
  end

  it "should generate a rakefile that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@rakefile} > #{null_device}").should be_true
  end
  
  it "should generate an initializer that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@initializer} > #{null_device}").should be_true
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

end
