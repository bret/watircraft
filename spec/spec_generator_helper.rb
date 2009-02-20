#### Rubigen helpers
require 'rubigen'
require 'rubigen/helpers/generator_test_helper'


def generator_sources
  [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "app_generators")),
  RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "watircraft_generators"))]
end

module Helpers
  module Generator
    def generate_site(site_name)
      site_name = "#{site_name}#{Time.now.to_i}"
      run_generator('site', [site_name], generator_sources)
      site_file_path = File.join(PROJECT_FOLDER,'lib',"#{site_name.underscore}.rb")
      require site_file_path
      "::#{site_name.camelize}::#{site_name.camelize}".constantize.any_instance.stubs(:base_path).returns(PROJECT_FOLDER)
      site_name.camelize.constantize
    end
    def generate_project
      run_generator('watircraft', [APP_ROOT], generator_sources)
      ::Taza::Settings.stubs(:path).returns(APP_ROOT)       
    end
  end
  
  module Taza
    def stub_settings
      ::Taza::Settings.stubs(:config).returns({})
    end

    def stub_browser
      stub_browser = stub()
      stub_browser.stubs(:goto)
      stub_browser.stubs(:close)
      ::Taza::Browser.stubs(:create).returns(stub_browser)
    end
  end
end
#### Rubigen helpers end
