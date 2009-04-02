module Taza
  class Browser
    
    class << self
    
      # Create a browser instance depending on configuration.  Configuration should be read in via Taza::Settings.config.
      # 
      # Example:
      #     browser = Taza::Browser.create(Taza::Settings.config)
      #
      def create(params={})
        send("create_#{params[:driver]}", params)
      end
  
      private    
  
      def create_watir(params)
        require 'watir'
        require 'extensions/watir'
        Watir::Browser.default = params[:browser]
        case params[:browser]
          when 'ie'
            require 'watir/ie'
            Watir.add_display_value_methods_to Watir
            Watir::IE.set_options(:visible => params[:visible])
            browser = provision_watir_browser params
            browser.speed = params[:speed]
          when 'firefox'
            require 'firewatir'
            Watir.add_display_value_methods_to FireWatir
            browser = provision_watir_browser params
          else
            browser = provision_watir_browser params
        end
            
        browser
      end

      def provision_watir_browser(params)
        Watir::Browser.new
      end
  
      def create_selenium(params)
        require 'selenium'
        Selenium::SeleniumDriver.new(params[:server_ip],params[:server_port],'*' + params[:browser],params[:timeout])
      end
      
      def create_fake(params)
        FakeBrowser.new
      end
    end

  end

  class FakeBrowser
    def goto(*args)
    end
    def close
    end
    
  end
  
end

