require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

namespace :spec do  
  FileUtils.mkdir("artifacts") unless File.directory?("artifacts")
  desc "Run all functional specs "
  Spec::Rake::SpecTask.new :functional do |t|
    t.spec_files = 'spec/functional/**/*_spec.rb'
    t.spec_opts=["--format html:artifacts/all_functional.html"]   
  end
  desc "Run all integration specs "
  Spec::Rake::SpecTask.new :integration do |t|
    t.spec_files = 'spec/integration/**/*_spec.rb'
    t.spec_opts=["--format html:artifacts/all_integration.html"]    
  end

  namespace :functional do
    Dir.glob('./spec/functional/*/').each do |dir|
      site_name = File.basename(dir)
      desc "Run all functional specs for #{site_name} "
      Spec::Rake::SpecTask.new site_name.to_sym do |t|
        t.spec_files = "#{dir}**/*_spec.rb"
        t.spec_opts=["--format html:artifacts/#{site_name}_functional.html"]        
      end
    end
  end  
end



