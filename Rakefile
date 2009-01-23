# -*- ruby -*-
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'rubygems'
require 'config/vendorized_gems'
require 'taza'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

ARTIFACTS_DIR = 'artifacts'

RCOV_THRESHOLD = 100.0
RCOV_DIR = File.join(ARTIFACTS_DIR,"rcov")

FLOG_THRESHOLD = 40.0
FLOG_REPORT = File.join(ARTIFACTS_DIR,"flog_report.txt")
FLOG_LINE = /^(.*): \((\d+\.\d+)\)/

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'taza'
    s.rubyforge_project = 'taza'
    s.email = "adamandersonis@gmail.com"
    s.homepage = "http://github.com/scudco/taza"
    s.summary = "Taza is an opionated browser-based testing framework."
    s.description = "Taza is an opionated browser-based testing framework."
    s.authors = ["Adam Anderson"]

    s.executables = ["taza"]
    s.files = FileList["[A-Z]*.*", "{bin,generators,lib,spec}/**/*"]
    s.add_dependency(%q<taglob>, [">= 1.1.1"])
    s.add_dependency(%q<rake>, [">= 0.8.3"])
    s.add_dependency(%q<mocha>, [">= 0.9.3"])
    s.add_dependency(%q<rspec>, [">= 1.1.12"])
    s.add_dependency(%q<rubigen>, [">= 1.4.0"])

    s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README"]
    s.has_rdoc = true
    s.rdoc_options = ["--main", "README"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end  

desc "Build RDoc"
task :rdoc do
  system "ruby ./vendor/gems/gems/allison-2.0.3/bin/allison --line-numbers --inline-source --main README --title 'Taza RDoc' README History.txt lib "
end

Spec::Rake::SpecTask.new do |t|
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.libs << File.join(File.dirname(__FILE__), 'lib')
  t.rcov = true
  t.rcov_dir = RCOV_DIR
  t.rcov_opts << '--text-report'
  t.rcov_opts << '--exclude spec'
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
  puts File.readlines(FLOG_REPORT).select {|line| line =~ FLOG_LINE || line =~ /Total Flog/}
end
 
desc "Verify Flog Score is under threshold"
task :verify_flog => :flog do |t|
  # I hate how ridiclous this is (Adam)
  messages = File.readlines(FLOG_REPORT).inject([]) do |messages,line|
    line =~ FLOG_LINE && $2.to_f > FLOG_THRESHOLD ?
      messages << "#{$1}(#{$2})" : messages
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

desc "Should you check-in?"
task :quick_build => [:verify_rcov, :verify_flog]

# vim: syntax=ruby
