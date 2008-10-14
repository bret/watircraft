module Taza
  class Browser
    
    def self.create(params={})
      self.send("create_#{params[:driver]}".to_sym,params)
    end

    private    

    def self.create_watir(params)
      method = "create_watir_#{params[:browser]}"
      raise BrowserUnsupportedError unless self.respond_to?(method)
      self.send(method)
    end

    def self.create_selenium(params)
      require 'selenium'
      Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser].to_s,params[:timeout])
    end
    
    def self.create_watir_ie
      require 'watir'
      Watir::IE.new
    end
    
    def self.create_watir_firefox
    end
    
    def self.create_watir_safari
      require 'safariwatir'
      Watir::Safari.new
    end
        
  end
end

class BrowserUnsupportedError < StandardError
end