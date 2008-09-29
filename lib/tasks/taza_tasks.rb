require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob'
require 'spec/rake/spectask'

private
def get_tagged_files(test_file_pattern)
  Dir.taglob(test_file_pattern,ENV['tags'])
end
public

Rake::TestTask.new :test_tag do |t|
  t.test_files = get_tagged_files('/test/**/test_*.rb')
end

Spec::Rake::SpecTask.new :spec_tag do |t|
  t.spec_files = get_tagged_files('spec/**/*_spec.rb')
end

namespace :generate do
  task :site do
    SiteGenerator.new(ENV['name']).generate
  end
end
