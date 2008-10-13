require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'
require 'taza/generators'

private

def validate_required_environment_input_present(error_message, *environment_variable_keys)
  environment_variable_keys.each do |environment_variable_key|
    if ENV[environment_variable_key].nil?
      STDERR.puts error_message
      exit 1
    end
  end
end

public

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
