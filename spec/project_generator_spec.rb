require 'spec/spec_helper'
require 'spec/spec_generator_helper'
require 'rubygems'
require 'rake'
require 'fileutils'
require 'taza'

describe "Project Generator" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  
  def project_file relative_path
    File.join(TMP_ROOT, PROJECT_NAME, relative_path)
  end
  def project_folder project_name=PROJECT_NAME
    File.join(TMP_ROOT, project_name)
  end
  
  before :each do
    ENV['ENVIRONMENT'] = nil
    bare_setup
    
    @site_folder = project_file 'lib'
    @page_folder = project_file 'lib/pages'
    @initializer = project_file 'lib/initialize.rb'
  end

  after :each do
    bare_teardown
  end

  def should_be_loadable file
    load_path = File.dirname(__FILE__) + '/../lib'
    system("ruby -I#{load_path} #{file} > #{null_device}").should be_true
  end

  it "should generate a spec helper that can be required even when site name is different" do
    generate_project ['--site=another_name', '--driver=fake']
    spec_helper = project_file 'test/specs/spec_helper.rb'
    should_be_loadable spec_helper
  end 

  it "should generate a feature helper that can be required" do
    generate_project ['--driver=fake']
    feature_helper = project_file 'test/features/feature_helper.rb'
    should_be_loadable feature_helper
  end

  it "should generate a world file that can be required" do
    generate_project ['--driver=fake']
    world = project_file 'lib/steps/world.rb'
    should_be_loadable world
  end

  it "should generate a rakefile that can be required" do
    generate_project
    rakefile = project_file 'rakefile'
    should_be_loadable rakefile
  end
  
  it "should generate an initializer that can be required" do
    generate_project
    should_be_loadable @initializer
  end
  
  it "should be able to update an existing project and figure out the site name" do
    generate_project ['--site=crazy']
    generate_project
    Taza::Settings.config[:site].should == 'crazy'
  end

  it "initializer should set the ENVIRONMENT variable if it is not provided" do
    generate_project
    load @initializer
    ENV['ENVIRONMENT'].should eql("test")
  end
  
  it "initializer should not override the ENVIRONMENT variable if was provided" do
    ENV['ENVIRONMENT'] = 'orange pie? is there such a thing?'
    generate_project
    load @initializer
    ENV['ENVIRONMENT'].should eql('orange pie? is there such a thing?')
  end
  
  it "should configure a project for watir, implicitly" do
    generate_project
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:driver].should == :watir
  end

  it "should allow a site name to be specified" do
    generate_project ['--site=site_name']
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:site].should == 'site_name'
  end
  
  it "should allow a browser driver to be specified" do
    generate_project ['--driver=nine_iron']
    Taza::Settings.stubs(:path).returns(APP_ROOT)
    ENV['ENVIRONMENT'] = 'test'
    Taza::Settings.config[:driver].should == :nine_iron
  end
  
  it "should generate a script/console" do
    generate_project
    File.exist?(project_file('script/console')).should be_true
    File.exist?(project_file('script/console.cmd')).should be_true
  end

  it "should generate configuration file for a site" do
    generate_project
    File.exists?(File.join(PROJECT_FOLDER,'config','environments.yml')).should be_true
  end

  it "should generate site files and folders" do
    generate_project
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
    File.exists?("#{@site_folder}/example.rb").should be_true
  end

  it "should generate a site path even if the site name is given with spaces" do
    generate_project ["--site=example foo"]
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
    File.exists?("#{@site_folder}/example_foo.rb").should be_true
  end

  it "should generate a site path even if the site name is given with underscores" do
    generate_project ["--site=example_foo"]
    File.directory?(@site_folder).should be_true
    File.directory?(@page_folder).should be_true
    File.exists?("#{@site_folder}/example_foo.rb").should be_true
  end
  
  include Helpers::Taza
  it "generated site that uses the block given in new" do
    site_name = "example#{Time.now.to_i}"
    generate_project ["--site=#{site_name}"]

    site_file_path = project_file "lib/#{site_name.underscore}.rb"
    require site_file_path
    "::#{site_name.camelize}::#{site_name.camelize}".constantize.any_instance.stubs(:base_path).returns(PROJECT_FOLDER)
    site_class = site_name.camelize.constantize
    
    stub_settings
    stub_browser
    foo = nil
    site_class.new {|site| foo = site}
    foo.should_not be_nil
    foo.should be_a_kind_of(Taza::Site)
  end
  

end
