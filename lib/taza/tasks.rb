require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

namespace :spec do  
  def options(file_name)
    ["--format","html:artifacts/#{file_name}.html","--format","-p"]
  end
  FileUtils.mkdir("artifacts") unless File.directory?("artifacts")
  desc "Run all functional specs "
  Spec::Rake::SpecTask.new :functional do |t|
    t.spec_files = 'spec/functional/**/*_spec.rb'
    t.spec_opts<<options("all_functional")
  end
  desc "Run all integration specs "
  Spec::Rake::SpecTask.new :integration do |t|
    t.spec_files = 'spec/integration/**/*_spec.rb'
    t.spec_opts<<options("all_integration")
  end

  namespace :functional do
    Dir.glob('./spec/functional/*/').each do |dir|
      site_name = File.basename(dir)
      desc "Run all functional specs for #{site_name} "
      Spec::Rake::SpecTask.new site_name.to_sym do |t|
        t.spec_files = "#{dir}**/*_spec.rb"
        t.spec_opts<<options("#{site_name}_functional")
      end
    end
  end
end