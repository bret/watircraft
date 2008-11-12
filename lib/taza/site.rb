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
      @browser.goto(params[:url] || config[:url])

      if block_given?
        begin
          yield self
        rescue => site_block_exception
        ensure
          begin
            @@before_browser_closes.call(browser)
          rescue => before_browser_closes_block_exception
          end
          close_browser_and_raise_if site_block_exception || before_browser_closes_block_exception
        end
      end
    end
    
    def self.settings
      Taza::Settings.site_file(self.name)
    end

    def close_browser_and_raise_if(original_error)
      begin
        @browser.close
      ensure
        raise original_error if original_error
      end
    end

    def define_site_pages # :nodoc:
      Dir.glob(pages_path) do |file|
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

    def pages_path # :nodoc:
      File.join('lib','sites',self.class.to_s.underscore,'pages','*.rb')
    end
    
  end
end
