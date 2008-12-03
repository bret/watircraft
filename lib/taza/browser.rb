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


    private    

    def self.create_watir(params)
      method = "create_watir_#{params[:browser]}"
      raise BrowserUnsupportedError unless self.respond_to?(method)
      watir = self.send(method)
      watir
    end

    def self.create_selenium(params)
      require 'selenium'
      Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser].to_s,params[:timeout])
    end
    
    def self.create_watir_firefox
      require 'firewatir'
      FireWatir::Firefox.new()
    end
        
  end

  class BrowserUnsupportedError < StandardError; end
end

