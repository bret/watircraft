require 'spec/spec_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper

  before :all do
    @spec_helper = File.join(TMP_ROOT, PROJECT_NAME, 'test/specs/spec_helper.rb')
    @feature_helper = File.join(TMP_ROOT, PROJECT_NAME, 'test/features/feature_helper.rb')
    @rakefile = File.join(TMP_ROOT,PROJECT_NAME, 'rakefile')
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

  it "should generate a spec helper that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@feature_helper} > #{null_device}").should be_true
  end

  it "should generate a rakefile that can be required" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    system("ruby -c #{@rakefile} > #{null_device}").should be_true
  end

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

end
