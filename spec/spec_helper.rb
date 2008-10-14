require 'rubygems'
require 'spec'
require 'mocha'

lib_path = File.expand_path("#{File.dirname(__FILE__)}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

def null_device  
  Taza.windows? ? 'NUL': '/dev/null'
end

require "rubygems"
Gem.clear_paths
gem_paths = [
  File.expand_path("#{File.dirname(__FILE__)}/../vendor/gems"),
  Gem.default_dir,
]
Gem.send :set_paths, gem_paths.join(":")