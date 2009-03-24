#### Rubigen helpers
require 'rubigen'
require 'rubigen/helpers/generator_test_helper'


def generator_sources
  [RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "app_generators")),
  RubiGen::PathSource.new(:test, File.join(File.dirname(__FILE__), "..", "watircraft_generators"))]
end

module Helpers
  module Generator
    def generate_project options=[]
      generator_args = [APP_ROOT] + options
      run_generator('watircraft', generator_args, generator_sources)
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
