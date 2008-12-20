# -*- ruby -*-
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'config/vendorized_gems'
require 'hoe'
require 'taza'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

ARTIFACTS_DIR = 'artifacts'

RCOV_THRESHOLD = 100.0
RCOV_DIR = File.join(ARTIFACTS_DIR,"rcov")

FLOG_THRESHOLD = 40.0
FLOG_REPORT = File.join(ARTIFACTS_DIR,"flog_report.txt")

def spec_files
  return FileList['spec/**/*_spec.rb'].exclude(/spec\/platform\/(?!osx)/) if Taza.osx?
  return FileList['spec/**/*_spec.rb'].exclude(/spec\/platform\/(?!windows)/) if Taza.windows?
  return FileList['spec/**/*_spec.rb'].exclude('spec/platform/*')
end

Hoe.new('taza', Taza::VERSION) do |p|
  p.rubyforge_name = 'taza' # if different than lowercase project name
  p.developer('Adam Anderson', 'adamandersonis@gmail.com')
  p.remote_rdoc_dir = ''
  p.extra_deps << ['taglob','>= 1.1.1']
  p.extra_deps << ['rake','>= 0.8.3']
  p.extra_deps << ['hoe','>= 1.8.2']
  p.extra_deps << ['mocha','>= 0.9.0']
  p.extra_deps << ['rspec','>= 1.1.11']
  p.extra_deps << ['rubigen','>= 1.3.4']
end

desc "Build RDoc"
task :rdoc do
  system "ruby ./vendor/gems/gems/allison-2.0.3/bin/allison --line-numbers --inline-source --main README.txt --title 'Taza RDoc' README.txt History.txt lib "
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
  t.rcov_dir = RCOV_DIR
  t.rcov_opts << '--text-report'
end

desc "Verify Code Coverage"
RCov::VerifyTask.new(:verify_rcov => :rcov) do |t|
  t.threshold = RCOV_THRESHOLD
  t.index_html = File.join(RCOV_DIR,"index.html")
end

desc "Run flog against all the files in the lib"
task :flog do
  require "flog"
  flogger = Flog.new
  flogger.flog_files Dir["lib/**/*.rb"]
  FileUtils.mkdir_p(ARTIFACTS_DIR)
  File.open(FLOG_REPORT,"w") {|file| flogger.report file }
  puts File.readlines(FLOG_REPORT).select {|line| line =~ /^(.*): \((\d+\.\d+)\)/}
end
 
desc "Verify Flog Score is under threshold"
task :verify_flog => :flog do |t|
  messages = File.readlines(FLOG_REPORT).inject([]) do |messages,line|
    if line =~ /^(.*): \((\d+\.\d+)\)/ && $2.to_f > FLOG_THRESHOLD
      messages << "#{$1}(#{$2})"
    else
      messages
    end
  end
  #lol flog log
  flog_log = "\nFLOG THRESHOLD(#{FLOG_THRESHOLD}) EXCEEDED\n #{messages.join("\n ")}\n\n"
  raise flog_log unless messages.empty?
end

desc "Run saikuro cyclo complexity against the lib"
task :saikuro do
  #we can specify options like ignore filters and set warning or error thresholds
  system "ruby vendor/gems/gems/Saikuro-1.1.0/bin/saikuro -c -t -i lib -y 0 -o #{ARTIFACTS_DIR}/saikuro"
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

desc "Should you check-in?"
task :quick_build => [:verify_rcov, :verify_flog]

# vim: syntax=ruby
