require 'rubygems'
require 'activesupport'

module Taza
  class Site
    attr_accessor :browser

    def initialize(params={})
      define_site_pages
      config = Settings.config(self.class.to_s)
      @browser = params[:browser] || Browser.create(config)

      begin
        @browser.goto(params[:url] || config[:url])
        if block_given?
          yield self
          @browser.close
        end
      rescue => ex
        attempt_to_close_browser(ex)
      end
      
    end
    
    def self.settings
      Taza::Settings.site_file(self.name)
    end

    def attempt_to_close_browser(previous_error)
      begin
        @browser.close
      ensure
        raise previous_error
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
