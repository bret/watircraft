require 'taza/browsers/ie_watir'
require 'taza/browsers/safari_watir'

module Taza
  class Browser
    
    # Create a browser instance depending on configuration.  Configuration should be read in via Taza::Settings.config.
    # 
    # Example:
    #     browser = Taza::Browser.create(Taza::Settings.config)
    #
    def self.create(params={})
      self.send("create_#{params[:driver]}".to_sym,params)
    end
    
    def self.browser_class(params)
      self.send("#{params[:driver]}_#{params[:browser]}".to_sym)
    end

    private    

    def self.create_watir(params)
      method = "watir_#{params[:browser]}"
      raise BrowserUnsupportedError unless self.respond_to?(method)
      watir = self.send(method).new
      watir
    end

    def self.create_selenium(params)
      require 'selenium'
      Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser].to_s,params[:timeout])
    end

    def self.watir_firefox
      require 'firewatir'
      FireWatir::Firefox
    end

    def self.watir_safari
      require 'safariwatir'
      Watir::Safari
    end

    def self.watir_ie
      require 'watir'
      Watir::IE
    end
  end
  
  # We don't know how to create the browser you asked for
  class BrowserUnsupportedError < StandardError; end
end

