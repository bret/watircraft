require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

namespace :spec do
  desc "run all functional specs"
  Spec::Rake::SpecTask.new :functional do |t|
    t.spec_files = 'spec/functional/**/*_spec.rb'
  end
  desc "run all integration specs"
  Spec::Rake::SpecTask.new :integration do |t|
    t.spec_files = 'spec/integration/**/*_spec.rb'
  end
  
  namespace :functional do
    Dir.glob('./spec/functional/*/').each do |dir|
      site_name = File.basename(dir)
      desc "run all functional specs for #{site_name}"
      Spec::Rake::SpecTask.new site_name.to_sym do |t|
        t.spec_files = "#{dir}**/*_spec.rb"
      end
    end
  end
end
