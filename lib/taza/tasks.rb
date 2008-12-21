require 'rubygems'
require 'rake'
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

      def define_spec_task(name,glob_path)
        Spec::Rake::SpecTask.new name do |t|
          t.spec_files = Dir.taglob(glob_path,tags)
          t.spec_opts << spec_opts
        end
      end

      def define
        namespace :spec do
          desc "Run all functional specs"
          define_spec_task(:functional,'spec/functional/**/*_spec.rb')
          desc "Run all integration specs"
          define_spec_task(:integration,'spec/integration/**/*_spec.rb')

          namespace :functional do
            Dir.glob('./spec/functional/*/').each do |dir|
              site_name = File.basename(dir)
              desc "Run all functional specs for #{site_name}"
              define_spec_task(site_name,"#{dir}**/*_spec.rb")

              namespace site_name do
                Dir.glob("./spec/functional/#{site_name}/*_spec.rb").each do |page_spec_file|
                  page_name = File.basename(page_spec_file,'_spec.rb')
                  define_spec_task(page_name,page_spec_file)
                end
              end

            end
          end

        end
      end
    end
  end
end
