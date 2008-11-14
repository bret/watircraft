require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'
require 'vendor/gems/gems/rubigen-1.3.2/test/test_generator_helper'

class Taza::Site
  def flows
    flows = []
    Dir.glob(File.join(path,'flows','*.rb')).each do |file|
      require file

      flows << "#{self.class.parent.to_s}::#{File.basename(file,'.rb').camelize}".constantize
    end
    flows
  end
end

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

  # ack how did we nub this again?!
  it "should generate flows that will not have namespace collisions with other sites' flows" do
    new_site_name = "Pag"
    new_site_folder = File.join(PROJECT_FOLDER,'lib','sites',"pag")
    new_site_file = File.join(PROJECT_FOLDER,'lib','sites',"pag.rb")
    run_generator('site', [new_site_name], generator_sources)
    run_generator('flow', [@flow_name,@site_name], generator_sources)
    run_generator('flow', [@flow_name,new_site_name], generator_sources)
    require @site_file
    require new_site_file
    Taza::Settings.stubs(:config).returns({})
    stub_browser = stub()
    stub_browser.stubs(:goto)
    Taza::Browser.stubs(:create).returns(stub_browser)
    site_class = "#{@site_name}::#{@site_name}".constantize
    new_site_class = "#{new_site_name}::#{new_site_name}".constantize
    site_class.any_instance.stubs(:path).returns(@site_folder)
    new_site_class.any_instance.stubs(:path).returns(new_site_folder)
    (site_class.new.flows & new_site_class.new.flows).should be_empty
  end
end
