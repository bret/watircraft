require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

namespace :spec do
  def format_options(file_name)
    file_name = "artifacts/#{file_name}/index.html"
    dir_name = File.dirname(file_name)
    FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)
    ["--format","html:#{file_name}","--format","p"]
  end

  desc "Run all functional specs"
  Spec::Rake::SpecTask.new :functional do |t|
    t.spec_files = 'spec/functional/**/*_spec.rb'
    t.spec_opts << format_options("functional/all")
  end
  desc "Run all integration specs"
  Spec::Rake::SpecTask.new :integration do |t|
    t.spec_files = 'spec/integration/**/*_spec.rb'
    t.spec_opts << format_options("integration/all")
  end

  namespace :functional do
    Dir.glob('./spec/functional/*/').each do |dir|
      site_name = File.basename(dir)
      desc "Run all functional specs for #{site_name}"
      Spec::Rake::SpecTask.new site_name.to_sym do |t|
        t.spec_files = "#{dir}**/*_spec.rb"
        t.spec_opts << format_options("functional/#{site_name}/all")
      end
      namespace site_name.to_sym do
        Dir.glob("./spec/functional/#{site_name}/*_spec.rb").each do |page_spec_file|
          page_spec_name = File.basename(page_spec_file)
          page_name = page_spec_name.chomp('_spec.rb')
          Spec::Rake::SpecTask.new page_name.to_sym do |t|
            t.spec_files = page_spec_file
            t.spec_opts << format_options("functional/#{site_name}/#{page_name}")
          end
        end
      end
    end
  end
end
