require 'rubygems'
require 'activesupport'
require 'taza/settings'

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
    
    # These methods are available for user contexts, including Site itself
    module Methods
      attr_accessor :browser, :site
      
      # Return an instance of the specified page. The name
      # Given should be the human-form of the page, without the
      # "page" suffix.
      # If a block is given, it yields to the page.
      def page(page_name, &block)
        method_name = page_name.computerize + '_page'
        send method_name, &block
      end

      # Send the browser to a url, relative to the site origin.
      def goto relative_url
        destination = File.join(@site.origin, relative_url) 
        @browser.goto destination
      end

    end
    
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
    attr_accessor :methods

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
    # (not sure if this is a useful feature or not)
    def initialize(params={}, &block)
      @site = self
      @module_name = self.class.parent.to_s
      @class_name  = self.class.to_s.split("::").last

      define_flows

      if params[:browser]
        @browser = params[:browser]
      else
        @browser = Browser.create(config)
        @i_created_browser = true
      end

      @methods = PageLoader.new(@module_name, pages_path).page_methods
      @methods.send(:include, Methods)
      self.extend(@methods)
      
      @browser.goto origin

      execute_block_and_close_browser(&block) if block_given?
    end

    def config
      Settings.config(@class_name)
    end
    
    # The base url of the site. This is configured in environments.yml.
    def origin
      config[:url]
    end

    def execute_block_and_close_browser
      begin
        yield self
      rescue => site_block_exception
      ensure
        begin
          close
        rescue => close_exception
          ""
        end
        exception = site_block_exception || close_exception
        raise exception if exception
      end
    end
    private :execute_block_and_close_browser

    def close
      begin
        @@before_browser_closes.call(@browser)
      rescue => before_browser_closes_block_exception
        "" # so basically rcov has a bug where it would insist this block is uncovered when empty
      end
      begin
        @browser.close if @i_created_browser
      ensure
        raise before_browser_closes_block_exception if before_browser_closes_block_exception
      end
    end
    
    private
    def pages_path # :nodoc:
      File.join(path,'pages','**','*.rb') # does this need to include partials?
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

    #
    # methods that neither depend on or modify state
    #

    private
    def flows_path # :nodoc:
      File.join(path,'flows','*.rb')
    end

    def path # :nodoc:
      File.join(base_path,'lib')
    end

    def base_path # :nodoc:
      APP_ROOT
    end
    
    class PageLoader
      attr_reader :page_methods
      def initialize site_module, pages_path
        @site_module = site_module
        @pages_path = pages_path
        @page_methods = Module.new
        define_site_pages
      end
      private
      def define_site_pages # :nodoc:
        Dir.glob(@pages_path) do |file|
          require file
          page_name = File.basename(file,'.rb')
          page_class = "#{@site_module}::#{page_name.camelize}"
          @page_methods.module_eval <<-EOS
          def #{page_name}
            page = #{page_class}.new
            page.browser = @browser
            page.site = @site
            yield page if block_given?
            page
          end
          EOS
        end
      end
    end
  end
end
