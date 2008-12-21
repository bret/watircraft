require 'rubygems'
require 'activesupport'

module Taza
  # An abstraction of a website, but more really a container for a sites pages.
  #
  # You can generate a site by performing the following command:
  #   $ ./script/generate site google
  #
  # This will generate a site file for google, a flows folder, and a pages folder in lib
  #
  # Example:
  #
  #   require 'taza'
  #
  #   class Google < Taza::Site
  #
  #   end
  class Site
    @@before_browser_closes = Proc.new() {}
    # Use this to do something with the browser before it closes, but note that it is a class method which
    # means that this will get called for any instance of a site.
    #
    # Here's an example of how you might use it to print the DOM output of a browser before it closes:
    #
    #   Taza::Site.before_browser_closes do |browser|
    #     puts browser.html
    #   end
    def self.before_browser_closes(&block)
      @@before_browser_closes = block
    end
    attr_accessor :browser

    # A site can be called a few different ways
    #
    # The following example creates a new browser object and closes it:
    #  Google.new do
    #    google.search.set "taza"
    #    google.submit.click
    #  end
    #
    # This example will create a browser object but not close it:
    #  Google.new.search.set "taza"
    #
    # Sites can take a couple of parameters in the constructor:
    #   :browser => a browser object to act on instead of creating one automatically
    #   :url => the url of where to start the site
    def initialize(params={},&block)
      @module_name = self.class.parent.to_s
      @class_name  = self.class.to_s.split("::").last
      define_site_pages
      define_flows
      config = Settings.config(@class_name)
      if params[:browser]
        @browser = params[:browser]
      else
        @browser = Browser.create(config)
        @i_created_browser = true
      end
      @browser.goto(params[:url] || config[:url])
      execute_block_and_close_browser(browser,&block) if block_given?
    end

    def execute_block_and_close_browser(browser)
      begin
        yield self
      rescue => site_block_exception
      ensure
        begin
          @@before_browser_closes.call(browser)
        rescue => before_browser_closes_block_exception
          "" # so basically rcov has a bug where it would insist this block is uncovered when empty
        end
        close_browser_and_raise_if site_block_exception || before_browser_closes_block_exception
      end
    end

    def self.settings # :nodoc:
      Taza::Settings.site_file(self.name.to_s.split("::").last)
    end

    def close_browser_and_raise_if original_error # :nodoc:
      begin
        @browser.close if @i_created_browser
      ensure
        raise original_error if original_error
      end
    end

    def define_site_pages # :nodoc:
      Dir.glob(pages_path) do |file|
        require file
        page_name = File.basename(file,'.rb')
        page_class = "#{@module_name}::#{page_name.camelize}"
        self.class.class_eval <<-EOS
        def #{page_name}
          page = '#{page_class}'.constantize.new
          page.browser = @browser
          yield page if block_given?
          page
        end
        EOS
      end
    end

    def define_flows # :nodoc:
      Dir.glob(flows_path) do |file|
        require file
      end
    end

    # This is used to call a flow belonging to the site
    #
    # Example:
    #  Google.new do |google|
    #    google.flow(:perform_search, :query => "taza")
    #  end
    #
    # Where the flow would be defined under lib/sites/google/flows/perform_search.rb and look like:
    #  class PerformSearch < Taza::Flow
    #    alias :google :site
    #
    #    def run(params={})
    #      google.search.set params[:query]
    #      google.submit.click
    #    end
    #  end

    def pages_path # :nodoc:
      File.join(path,'pages','**','*.rb')
    end

    def flows_path # :nodoc:
      File.join(path,'flows','*.rb')
    end

    def path # :nodoc:
      File.join(base_path,'lib','sites',@class_name.underscore)
    end

    def base_path # :nodoc:
      '.'
    end
  end
end
