# -*- ruby -*-
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'hoe'
require 'taza'
require 'rbconfig'
require 'spec/rake/spectask'

Dir.glob(File.join("vendor","gems","gems","*")).each do |path|
  lib_path = path + "/lib/"
  $LOAD_PATH << lib_path
  gem_name = File.basename(Dir.glob(lib_path + "*.rb").first,".rb")
  require gem_name
end

private
def spec_files
  return FileList['spec/**/*_spec.rb'].exclude('spec/platform/windows/*') if Taza.osx?
  return FileList['spec/**/*_spec.rb'].exclude('spec/platform/osx/*') if Taza.windows?
  return FileList['spec/**/*_spec.rb'].exclude('spec/platform/*')
end
public

Hoe.new('taza', Taza::VERSION) do |p|
  p.rubyforge_name = 'taza' # if different than lowercase project name
  p.developer('Adam Anderson', 'adamandersonis@gmail.com')
  p.remote_rdoc_dir = ''
end

Spec::Rake::SpecTask.new do |t|
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.spec_files = spec_files
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = spec_files
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.rcov = true
  t.rcov_dir = 'artifacts'
  t.rcov_opts = ['--exclude', 'spec']
end

desc "Run flog against all the files in the lib"
task :flog do
  require "flog"
  flogger = Flog.new
  flogger.flog_files Dir["lib/**/*.rb"]
  FileUtils.mkdir('artifacts') unless File.directory?('artifacts')
  File.open("artifacts/flogreport.txt","w") do |file|
    flogger.report file
  end
end

desc "Run saikuro cyclo complexity against the lib"
task :saikuro do
  #we can specify options like ignore filters and set warning or error thresholds
  system "ruby vendor/gems/gems/Saikuro-1.1.0/bin/saikuro -c -t -i lib -y 0 -o artifacts"
end

namespace :gem do
  desc "install a gem into vendor/gems"
  task :install do
    if ENV["name"].nil?
      STDERR.puts "Usage: rake gem:install name=the_gem_name"; exit 1
    end
    gem = Taza.windows? ? "gem.bat" : "gem"
    system "#{gem} install #{ENV['name']} --install-dir=vendor/gems  --no-rdoc --no-ri -p ""http://10.8.77.100:8080"""
  end
end

#define a task which uses flog
# vim: syntax=ruby
