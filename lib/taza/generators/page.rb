require 'taza/generators/base'

module Taza
  module Generators
    class Page < Base
      attr_accessor :file_name
      def initialize(file_name,site_name)
        @file_name = file_name
        @site_name = site_name
      end

      def folder_path
        '.'
      end

      def generate
        file "page.rb.erb", File.join(folder_path,'lib','sites', @site_name, "pages",  "#{@file_name}.rb")
        file "functional_page_spec.rb.erb", File.join(folder_path,'spec','functional',@site_name,"#{@file_name}_spec.rb")
      end

    end
  end
end
