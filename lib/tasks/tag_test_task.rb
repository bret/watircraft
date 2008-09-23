require 'rake'
require 'rake/testtask'
require 'rubygems'
require 'taglob'

module FTW
  module Tasks
    class TagTestTask
      attr_accessor :tags

      def self.create(name,&block)
        task = new(name)
        block.call(task) if block_given?
        task.define
        task
      end

      def initialize(name)
        @name = name
      end
      def define
        Rake::TestTask.new @name do |t|
          t.test_files = Dir.taglob('/test/**/test_*.rb',@tags)
        end
      end
    end
  end
end
