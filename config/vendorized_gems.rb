require "rubygems"
Gem.clear_paths
gem_paths = [
  File.expand_path("#{File.dirname(__FILE__)}/../vendor/gems"),
  Gem.default_dir,
]
Gem.send :set_paths, gem_paths.join(File::PATH_SEPARATOR)