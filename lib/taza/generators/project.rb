require 'taza/generators/base'

module Taza
  module Generators
    class Project < Base
      def initialize(path)
        @path = path
      end
      def generate
        folder @path
        file "rakefile.rb.erb", File.join(@path,"rakefile")
        folder File.join(@path,"lib")
        folder File.join(@path,"config")
        file "config.yml.erb", File.join(@path,"config","config.yml")
        folder File.join(@path,"lib","sites")
        folder File.join(@path,"lib","flows")
        folder File.join(@path,"spec")
        folder File.join(@path,"spec","functional")
        folder File.join(@path,"spec","integration")
      end
    end
  end
end
