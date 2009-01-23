require 'spec/spec_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper

  before :all do
    @spec_helper = File.join(TMP_ROOT,PROJECT_NAME,'spec','spec_helper.rb')
    @rakefile = File.join(TMP_ROOT,PROJECT_NAME,'rakefile')
  end

  before :each do
    bare_setup
  end

  after :each do
    bare_teardown
  end

  it "should generate a spec helper that can be required" do
    run_generator('taza', [APP_ROOT], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end

  it "should generate a rakefile that can be required" do
    run_generator('taza', [APP_ROOT], generator_sources)
    system("ruby -c #{@spec_helper} > #{null_device}").should be_true
  end

  it "spec helper should set the TAZA_ENV variable if it is not provided" do
    ENV['TAZA_ENV'] = nil
    run_generator('taza', [APP_ROOT], generator_sources)
    load @spec_helper
    ENV['TAZA_ENV'].should eql("isolation")
  end
  
  it "spec helper should not override the TAZA_ENV variable if was provided" do
    ENV['TAZA_ENV'] = 'orange pie? is there such a thing?'
    run_generator('taza', [APP_ROOT], generator_sources)
    load @spec_helper
    ENV['TAZA_ENV'].should eql('orange pie? is there such a thing?')
  end

end
