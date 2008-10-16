require 'rubygems'
require 'activesupport'

module Taza
  class Site
    attr_accessor :browser

    def initialize(params={})
      define_site_pages
      @browser = params[:browser] || Browser.create(Settings.config)
      if block_given?
        begin
          yield self
        rescue => ex
        ensure
          begin
            @browser.close
          ensure
            raise ex if ex
          end
        end
      end
    end

    def define_site_pages # :nodoc:
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

    def path # :nodoc:
      File.join('lib','sites',self.class.to_s.underscore,'pages','*.rb')
    end
  end
end
