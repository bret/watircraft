require 'taza/settings'

module WatirCraft
  # Assumes #site_name and #destination_root and #usage methods are defined.
  module GeneratorHelper
    protected
    def configured_validated_site
      site = configured_site
      check_if_site_exists site
      site
    end
    def configured_site
      site_name = Taza::Settings.config_file[:site]
    end
    def check_if_site_exists site_name=@site_name
      if site_name.nil?
        raise RubiGen::UsageError, 
          "Error. A site must first be specified in config.yml"
      end
      site_file = File.join(destination_root,'lib',"#{site_name.underscore}.rb")
      unless File.exists?(site_file)
        raise RubiGen::UsageError, 
          "Error. Site file #{site_file} not found. (Check config.yml)"
      end
    end    
  end
end