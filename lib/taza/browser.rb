module Taza
  class Browser
    
    def self.create(params={})
      defaults = {:browser => :firefox,
                  :driver  => :selenium}
      params = defaults.merge(params)
      
      self.send("create_#{params[:driver]}".to_sym,params[:browser])
    end
    
    def self.create_watir(browser)
      method = "create_watir_#{browser}"
      raise BrowserUnsupportedError unless self.respond_to?(method)
      self.send(method)
    end

    def self.create_selenium(browser)
    end

    private    
    def self.create_watir_ie
    end
    
    def self.create_watir_firefox
    end
    
    def self.create_watir_safari
    end
    
    
  end
end

class BrowserUnsupportedError < StandardError
end