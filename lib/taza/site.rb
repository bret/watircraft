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
    
    def self.settings # :nodoc:
      Taza::Settings.site_file(self.name)
    end

    def close_browser_and_raise_if(original_error) # :nodoc:
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
        page_class = "#{self.class.parent.to_s}::#{page_name.camelize}"
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
    def flow(name,params={})
      require File.join(path,'flows',name.to_s.underscore)
      flow_class = "#{self.class.parent.to_s}::#{name.to_s.camelize}".constantize
      flow_class.new(self).run(params)
    end

    def pages_path # :nodoc:
      File.join(path,'pages','*.rb')
    end

    def path # :nodoc:
      File.join(base_path,'lib','sites',self.class.to_s.underscore)
    end
    
    def base_path # :nodoc:
      '.'
    end
  end
end
