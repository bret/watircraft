require 'rubygems'
require 'spec'
require 'mocha'
begin
  # Needed for rspec 1.2.x. (Allows "ruby" to run specs.) 
  # But not available before that.
  require 'spec/autorun'
rescue LoadError
  nil
end

require 'config/vendorized_gems'
lib_path = File.expand_path("#{File.dirname(__FILE__)}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

# Must set before requiring generator libs.
TMP_ROOT = File.join(File.dirname(__FILE__),"sandbox","generated")
PROJECT_NAME = 'example'
PROJECT_FOLDER = File.join(TMP_ROOT,PROJECT_NAME)
APP_ROOT = File.join(TMP_ROOT, PROJECT_NAME)

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

def null_device  
  File.exists?('/dev/null') ? '/dev/null' : 'NUL'
end

