require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

def tags
  ENV['TAGS']
end

def format_options(file_name)
  file_name = "artifacts/#{file_name}/index.html"
  dir_name = File.dirname(file_name)
  FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)
  ["--format","html:#{file_name}","--format","p"]
end

desc "Run all functional specs"
Spec::Rake::SpecTask.new :spec do |t|
  t.spec_files = Dir.taglob('test/specs/**/*_spec.rb',tags)
  t.spec_opts << format_options("functional/all")
end
task :specs => :spec

require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format pretty --require lib/steps test/features"
end
