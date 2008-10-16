require 'spec/spec_helper'
require 'rubygems'
require 'rake'

describe "generation tasks" do
  
  before :each do
    @file_name ="./lib/taza/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
    load @file_name     
  end
  
  after :each do
    @rake = nil
  end
  
  it "should create a site file in lib/sites" do
    Taza::Generators::Site.any_instance.expects(:file).with('site.rb.erb','./lib/sites/foo.rb')
    Taza::Generators::Site.any_instance.expects(:folder).with('./lib/sites/foo')
    Taza::Generators::Site.any_instance.expects(:folder).with('./lib/sites/foo/flows')
    Taza::Generators::Site.any_instance.expects(:folder).with('./lib/sites/foo/pages')
    Taza::Generators::Site.any_instance.expects(:folder).with('./spec/functional/foo')
    ENV['name'] = 'foo'
    @rake.invoke_task("generate:site")
  end

  it "should create a page file in lib/sites" do
    Taza::Generators::Page.any_instance.expects(:file).with('page.rb.erb','./lib/sites/ecom/pages/home.rb')
    Taza::Generators::Page.any_instance.expects(:file).with('functional_page_spec.rb.erb','./spec/functional/ecom/home_spec.rb')
    ENV['site'] = 'ecom'
    ENV['name'] = 'home'
    @rake.invoke_task("generate:page")
  end
  
  it "page generation should throw error if no site provided" do
    STDERR.stubs(:puts)
    ENV['name'] = 'home'
    ENV['site'] = nil
    lambda {@rake.invoke_task("generate:page")}.should raise_error(SystemExit)
  end
  
  it "page generation should throw error if no name provided" do
    STDERR.stubs(:puts)
    ENV['name'] = nil
    ENV['site'] = 'something'
    lambda {@rake.invoke_task("generate:page")}.should raise_error(SystemExit)
  end
  
  it "site generation should throw error if no name provided" do
    STDERR.stubs(:puts)
    ENV['name'] = nil
    lambda {@rake.invoke_task("generate:site")}.should raise_error(SystemExit)
  end
end

