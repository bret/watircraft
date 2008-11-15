require 'rubygems'
require 'spec'
require 'mocha'
require 'config/vendorized_gems'
lib_path = File.expand_path("#{File.dirname(__FILE__)}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)
TMP_ROOT = File.join(File.dirname(__FILE__),"sandbox","generated")
PROJECT_NAME = 'example'
PROJECT_FOLDER = File.join(TMP_ROOT,PROJECT_NAME)


Spec::Runner.configure do |config|
  config.mock_with :mocha
end

def null_device  
  Taza.windows? ? 'NUL': '/dev/null'
end

def generator_sources
  [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..","lib", "app_generators")),
  RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__),"..", "generators"))]
end

module Helpers
  module Generator
    def generate_site(site_name)
      run_generator('site', [site_name], generator_sources)
      site_file_path = File.join(PROJECT_FOLDER,'lib','sites',"#{site_name.underscore}.rb")
      require site_file_path
      "::#{site_name.camelize}::#{site_name.camelize}".constantize.any_instance.stubs(:base_path).returns(PROJECT_FOLDER)
      site_file_path
    end
  end
  
  module Taza
    def stub_settings
      ::Taza::Settings.stubs(:config).returns({})
    end

    def stub_browser
      stub_browser = stub()
      stub_browser.stubs(:goto)
      ::Taza::Browser.stubs(:create).returns(stub_browser)
    end
  end
end
