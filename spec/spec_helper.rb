require 'rubygems'
require 'spec'
require 'mocha'

lib_path = File.expand_path("#{File.dirname(__FILE__)}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
