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
        folder File.join(@path,"lib","sites")
        folder File.join(@path,"lib","flows")
      end
    end
  end
end
