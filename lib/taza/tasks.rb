require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob/rake/tasks'
require 'spec/rake/spectask'

def tags
  ENV['TAGS']
end

module Taza
  module Rake
    class Tasks
      attr_accessor :spec_opts

      def initialize
        yield self if block_given?
        define
      end

      def define
        namespace :spec do
          desc "Run all functional specs"
          Spec::Rake::SpecTask.new :functional do |t|
            t.spec_files = Dir.taglob('spec/functional/**/*_spec.rb',tags)
            t.spec_opts << spec_opts
          end
          desc "Run all integration specs"
          Spec::Rake::SpecTask.new :integration do |t|
            t.spec_files = Dir.taglob('spec/integration/**/*_spec.rb',tags)
            t.spec_opts << spec_opts
          end

          namespace :functional do
            Dir.glob('./spec/functional/*/').each do |dir|
              site_name = File.basename(dir)
              desc "Run all functional specs for #{site_name}"
              Spec::Rake::SpecTask.new site_name.to_sym do |t|
                t.spec_files = Dir.taglob("#{dir}**/*_spec.rb",tags)
                t.spec_opts << spec_opts
              end
              namespace site_name.to_sym do
                Dir.glob("./spec/functional/#{site_name}/*_spec.rb").each do |page_spec_file|
                  page_spec_name = File.basename(page_spec_file)
                  page_name = page_spec_name.chomp('_spec.rb')
                  Spec::Rake::SpecTask.new page_name.to_sym do |t|
                    t.spec_files = page_spec_file
                    t.spec_opts << spec_opts
                  end
                end
              end
            end
          end

        end
      end
    end
  end
end
