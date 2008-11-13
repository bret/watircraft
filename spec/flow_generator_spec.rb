require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

describe "Flow Generation" do
  include RubiGen::GeneratorTestHelper

  before :all do
    @site_name = "Gap"
    @site_folder = File.join(PROJECT_FOLDER,'lib','sites',"gap")
    @site_file = File.join(PROJECT_FOLDER,'lib','sites',"gap.rb")
    @flow_name = "CheckOut"
    @flow_file = File.join(PROJECT_FOLDER,'lib','sites', "gap", "flows" , "check_out.rb")
    @page_file = File.join(PROJECT_FOLDER,'lib','sites','gap','pages','check_out_page.rb')
  end

  before :each do
    run_generator('taza', [APP_ROOT], generator_sources)
    run_generator('site', [@site_name], generator_sources)
  end

  after :each do
    bare_teardown
  end

  it "should generate a flow file in lib/\#{site_name}/flows/" do
    run_generator('flow', [@flow_name,@site_name], generator_sources)
    File.exists?(@flow_file).should be_true
  end

  it "should give you usage if you do not give two arguments" do
    FlowGenerator.any_instance.expects(:usage)
    lambda { run_generator('flow', [@flow_name], generator_sources) }.should raise_error
  end

  it "should give you usage if you give a site that does not exist" do
    FlowGenerator.any_instance.expects(:usage)
    $stderr.expects(:puts).with(regexp_matches(/NoSuchSite/))
    lambda { run_generator('flow', [@flow_name,"NoSuchSite"], generator_sources) }.should raise_error
  end

  it "should generate a flow that can be required" do
    run_generator('flow', [@flow_name,@site_name], generator_sources)
    system("ruby -c #{@flow_file} > #{null_device}").should be_true
  end

  it "should generate flows that will not have namespace collisions with pages" do
    run_generator('flow', [@flow_name,@site_name], generator_sources)
    run_generator('page', [@flow_name,@site_name], generator_sources)
    require @flow_file
    require @page_file
  end

end
