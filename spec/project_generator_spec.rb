require 'spec/spec_helper'
require 'spec/spec_generator_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper
  
  def project_file relative_path
    File.join(TMP_ROOT, PROJECT_NAME, relative_path)
  end
  def project_folder project_name=PROJECT_NAME
    File.join(TMP_ROOT, project_name)
  end
  
  before :each do
    @spec_helper = project_file 'test/specs/spec_helper.rb'
    @initializer = project_file 'lib/initialize.rb'
    ENV['ENVIRONMENT'] = nil
    bare_setup

    @site_name = PROJECT_NAME
    @site_folder = File.join(project_folder, 'lib')
    @site_file = File.join(@site_folder, "#{@site_name}.rb")
    @page_folder = File.join(@site_folder, 'pages')
  end

  after :each do
    bare_teardown
  end

  def should_be_loadable file, options=[]
    options = [options] unless options.is_a? Array
    generator_args = [APP_ROOT] + options
    run_generator('watircraft', generator_args, generator_sources)
    load_path = File.dirname(__FILE__) + '/../lib'
    system("ruby -I#{load_path} #{file} > #{null_device}").should be_true
  end

  it "should generate a spec helper that can be required even when site name is different" do
    should_be_loadable @spec_helper, ['--site=another_name', '--driver=fake']
  end

  it "should generate a feature helper that can be required" do
    feature_helper = project_file 'test/features/feature_helper.rb'
    should_be_loadable feature_helper, '--driver=fake'
  end

  it "should generate a world file that can be required" do
    world = project_file 'lib/steps/world.rb'
    should_be_loadable world, '--driver=fake'
  end

  it "should generate a rakefile that can be required" do
    rakefile = project_file 'rakefile'
    should_be_loadable rakefile
  end
  
  it "should generate an initializer that can be required" do
    should_be_loadable @initializer
  end
  
  it "should be able to update an existing project and figure out the site name" do
    run_generator('watircraft', [APP_ROOT, '--site=crazy'], generator_sources)
    run_generator('watircraft', [APP_ROOT, '--force'], generator_sources)
    Taza::Settings.config[:site].should == 'crazy'
  end

  it "initializer should set the ENVIRONMENT variable if it is not provided" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    load @initializer
    ENV['ENVIRONMENT'].should eql("test")
  end
  
  it "initializer should not override the ENVIRONMENT variable if was provided" do
    ENV['ENVIRONMENT'] = 'orange pie? is there such a thing?'
    run_generator('watircraft', [APP_ROOT], generator_sources)
    load @initializer
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
  
  it "should generate a script/console" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    File.exist?(project_file('script/console')).should be_true
    File.exist?(project_file('script/console.cmd')).should be_true
  end

  it "should generate configuration file for a site" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    File.exists?(File.join(PROJECT_FOLDER,'config','environments.yml')).should be_true
  end

  it "should generate a site path for pages" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
  end

  it "should generate a site path even if the site name is given with spaces" do
    run_generator('watircraft', [APP_ROOT, "--site=example foo"], generator_sources)
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
  end

  it "should generate a site path even if the site name is given with underscores" do
    run_generator('watircraft', [APP_ROOT, "--site=example_foo"], generator_sources)
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
  end
  
  include Helpers::Generator
  include Helpers::Taza
  it "generated site that uses the block given in new" do
    run_generator('watircraft', [APP_ROOT], generator_sources)
    @site_class = generate_site(@site_name)
    stub_settings
    stub_browser
    foo = nil
    @site_class.new {|site| foo = site}
    foo.should_not be_nil
    foo.should be_a_kind_of(Taza::Site)
  end
  

end
