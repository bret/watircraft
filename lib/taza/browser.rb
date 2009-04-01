module Taza
  class Browser
    
    # Create a browser instance depending on configuration.  Configuration should be read in via Taza::Settings.config.
    # 
    # Example:
    #     browser = Taza::Browser.create(Taza::Settings.config)
    #
    def self.create(params={})
      self.send("create_#{params[:driver]}".to_sym, params)
    end

    private    

    def self.create_watir(params)
      require 'watir'
      require 'extensions/watir'
      if params[:browser] == :ie
        require 'watir/ie'
        Watir.add_display_value_methods_to Watir
      end
      if params[:browser] == :firefox
        require 'firewatir'
        Watir.add_display_value_methods_to FireWatir
      end
      Watir::Browser.default = params[:browser].to_s
      Watir::Browser.new
    end

    def self.create_selenium(params)
      require 'selenium'
      Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser].to_s,params[:timeout])
    end
    
    def self.create_fake(params)
      FakeBrowser.new
    end

  end

  class FakeBrowser
    def goto(*args)
    end
    def close
    end
    
  end
  
end

