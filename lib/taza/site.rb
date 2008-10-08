require 'rubygems'
require 'activesupport'

module Taza
  class Site
    attr_accessor :browser

    def initialize(params={})
      define_site_pages
      @browser = params[:browser] || Browser.create
      yield self if block_given?
    end

    def define_site_pages
      Dir.glob(path) do |file|
        require file

        page_name = File.basename(file,'.rb')
        self.class.class_eval <<-EOS
        def #{page_name}
          page = '#{page_name}'.camelcase.constantize.new
          page.browser = @browser
          yield page if block_given? 
          page
        end
        EOS
      end
    end

    def path
      File.join('pages',self.class.to_s.underscore,'*.rb')
    end
  end
end
