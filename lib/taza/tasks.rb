require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob'
require 'spec/rake/spectask'
require 'taza/generators'

private
def get_tagged_files(test_file_pattern)
  Dir.taglob(test_file_pattern,ENV['tags'])
end

def validate_required_environment_input_present(error_message, *environment_variable_keys)
  environment_variable_keys.each do |environment_variable_key|
    if ENV[environment_variable_key].nil?
      STDERR.puts error_message
      exit 1
    end
  end
end

public

desc "invoke tests by tag"
Rake::TestTask.new :test_tag do |t|
  t.test_files = get_tagged_files('test/**/test_*.rb')
end

desc "invoke specs by tag"
Spec::Rake::SpecTask.new :spec_tag do |t|
  t.spec_files = get_tagged_files('spec/**/*_spec.rb')
end

namespace :generate do
  desc "generate a site(rake generate:site name=foo)"
  task :site do
    validate_required_environment_input_present("Usage: rake generate:site name=the_site_name",'name')
    Taza::Generators::Site.new(ENV['name']).generate
  end

  desc "generate a page(rake generate:page site=foo page=bar)"
  task :page do
    validate_required_environment_input_present("Usage: rake generate:page name=the_page_name site=the_site_name",'name','site')
    Taza::Generators::Page.new(ENV['name'],ENV['site']).generate
  end
end
