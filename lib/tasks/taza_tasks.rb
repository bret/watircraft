require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob'

Rake::TestTask.new :test_tag do |t|
  t.test_files = Dir.taglob('/test/**/test_*.rb',ENV['tags'])
end