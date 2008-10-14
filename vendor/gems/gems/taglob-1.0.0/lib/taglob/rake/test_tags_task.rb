require 'rake'
require 'rake/testtask'
require 'spec/rake/spectask'

module Taglob
  module Rake
    class TagsTask
      attr_accessor :pattern
      attr_accessor :tags

      def initialize(name)
        @name = name
        yield self if block_given?
        define
      end

      def test_files
        Dir.taglob(pattern,tags) unless tags.nil? || pattern.nil?
      end
    end
    
    class TestTagsTask < TagsTask
      def initialize(name = :test_tags)
        super(name)
      end
      
      def define
        ::Rake::TestTask.new @name do |t|
          t.test_files = test_files
        end
      end      
    end
    
    class SpecTagsTask < TagsTask
      def initialize(name = :spec_tags)
        super(name)
      end
      
      def define
        ::Spec::Rake::SpecTask.new @name do |t|
          t.spec_files = test_files
        end
      end
    end

  end
end