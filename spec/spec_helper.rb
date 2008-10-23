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

