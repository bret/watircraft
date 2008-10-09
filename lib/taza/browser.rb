module Taza
  class Browser
    
    def self.create(params={})
      defaults = {:browser => :firefox,
                  :driver  => :selenium}
      params = defaults.merge(params)
      
      self.send("create_#{params[:driver]}".to_sym,params[:browser])
    end
    
    def self.create_watir(browser)
    
    end
    
    def self.create_selenium(browser)
      
    end
    
  end
end
