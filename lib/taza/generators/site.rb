require 'taza/generators/base'

module Taza
  module Generators
    class Site < Base
      attr_accessor :file_name

      def initialize(file_name)
        @file_name = file_name
      end

      def folder_path
        '.'
      end

      def generate
        site_path = File.join(folder_path,'lib','sites')
        file "site.rb.erb", File.join(site_path,"#{file_name}.rb")
        folder File.join(site_path,"#{file_name}")
        folder File.join(site_path,"#{file_name}","flows")
        folder File.join(site_path,"#{file_name}","pages")
        folder File.join(folder_path,'spec','functional',@file_name)
      end
    end
  end
end
