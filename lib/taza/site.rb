require 'rubygems'
require 'activesupport'

module Taza
  class Site
    @@before_browser_closes = Proc.new() {}
    def self.before_browser_closes(&block)
      @@before_browser_closes = block
    end
    attr_accessor :browser

    def initialize(params={})
      define_site_pages
      config = Settings.config(self.class.to_s)
      @browser = params[:browser] || Browser.create(config)

      begin
        @browser.goto(params[:url] || config[:url])
        if block_given?
          yield self
          close_browser
        end
      rescue => ex
        close_browser_and_raise(ex)
      end
      
    end
    
    def self.settings
      Taza::Settings.site_file(self.name)
    end

    def close_browser
      @@before_browser_closes.call(browser)
      @browser.close
    end

    def close_browser_and_raise(original_error)
      begin
        close_browser
      ensure
        raise original_error
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
