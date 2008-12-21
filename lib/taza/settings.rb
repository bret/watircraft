require 'activesupport'

module Taza
  class Settings
    # The config settings for a site.yml file.  ENV variables will override the settings:
    #  Can override the browser in config via ENV['BROWSER']
    #  Can override the driver in config via ENV['DRIVER']
    #  Can override the timeout in config via ENV['TIMEOUT']
    #  Can override the server_ip in config via ENV['SERVER_IP']
    #  Can override the server_port in config via ENV['SERVER_PORT']
    #
    # Example:
    #   Taza::Settings.Config('google')
    def self.config(site_name)
      env_settings = {}
      env_settings[:browser] = ENV['BROWSER'].to_sym if ENV['BROWSER']
      env_settings[:driver]  = ENV['DRIVER'].to_sym if ENV['DRIVER']
      env_settings[:timeout] = ENV['TIMEOUT'] if ENV['TIMEOUT']
      env_settings[:server_ip] = ENV['SERVER_IP'] if ENV['SERVER_IP']
      env_settings[:server_port] = ENV['SERVER_PORT'] if ENV['SERVER_PORT']
      env_settings = {:browser=>:firefox,:driver=>:selenium}.merge(config_file.merge(env_settings))
      site_file(site_name).merge(env_settings)
    end

    # Loads the config file for the entire project and returns the hash.
    # Does not override settings from the ENV variables.
    def self.config_file
      YAML.load_file(config_file_path)
    end

    def self.config_file_path # :nodoc:
      File.join(config_folder,'config.yml')
    end
    
    def self.config_folder # :nodoc:
      File.join(path,'config')
    end
    
    def self.site_file(site_name) # :nodoc:
      YAML.load_file(File.join(config_folder,"#{site_name.underscore}.yml"))[ENV['TAZA_ENV']]
    end

    def self.path # :nodoc:
      '.'
    end
  end
end
