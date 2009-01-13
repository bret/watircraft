require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe "Page Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza

  before :each do
    generate_project
    @site_class = generate_site('Gap')
    @site_name = @site_class.to_s.underscore
  end

  after :each do
    bare_teardown   
  end
  
  # Negative
  
  it "should give you usage if you provide no arguments" do
    lambda { run_generator('page', [], generator_sources) }.
      should raise_error(RubiGen::UsageError)
  end

  it "should give you usage if you provide two arguments" do
    lambda { run_generator('page', ['simple', 'extra'], generator_sources) }.
      should raise_error(RubiGen::UsageError)
  end

  it "should display an error if no site is specified in the config.yml" do
    PageGenerator.any_instance.stubs(:configured_site).returns(nil)
    lambda { run_generator('page', ['simple'], generator_sources) }.
      should raise_error(RubiGen::UsageError, "Error. A site must first be specified in config.yml")
  end

  it "should display an error if the site in config.yml can't be found" do
    PageGenerator.any_instance.stubs(:configured_site).returns('no_such_site')
    lambda { run_generator('page', ['simple'], generator_sources) }.
      should raise_error(RubiGen::UsageError, /Error\. Site file .*lib\/no_such_site.rb not found\./)
  end
    
  # Positive

  it "should be able to access the generated page from the site" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)    
    run_generator('page', ['simple'], generator_sources)
    stub_settings
    stub_browser
    @site_class.new.simple_page
  end

  it "should be able to access the generated page when it has a space" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)    
    run_generator('page', ['check out'], generator_sources)
    stub_settings
    stub_browser
    @site_class.new.check_out_page
  end

  it "should be able to access the generated page when it has an underscore" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)    
    run_generator('page', ['check_any'], generator_sources)
    stub_settings
    stub_browser
    @site_class.new.check_any_page
  end
  
  it "should be able to generate a page using the project default" do
    lambda{run_generator('page', ['simple'], generator_sources)}.
      should_not raise_error
  end
  
  it "should provide the module name of the site" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)
    generator = PageGenerator.new(['sample'])
    generator.site_module.should == @site_class.to_s
  end
  it "should provide the name of the page class" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)
    generator = PageGenerator.new(['sample'])
    generator.page_class.should == 'SamplePage'
  end
  
  it "should work when when the provided page name includes a space" do
    PageGenerator.any_instance.stubs(:configured_site).returns(@site_name)
    generator = PageGenerator.new(['check out'])
    generator.page_class.should == 'CheckOutPage'
  end
    
end
