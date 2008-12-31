module Taza
  # Assumes #site_name and #destination_root and #usage methods are defined.
  module GeneratorHelper
    def check_if_site_exists
      if @site_name.nil?
        raise RubiGen::UsageError, 
          "Error. A site must first be specified in config.yml"
      end
      site_file = File.join(destination_root,'lib',"#{@site_name.underscore}.rb")
      unless File.exists?(site_file)
        raise RubiGen::UsageError, 
          "Error. Site file #{site_file} not found. (Check config.yml)"
      end
    end    
  end
end