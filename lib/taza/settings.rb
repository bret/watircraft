require 'activesupport'

module Taza
  class Settings
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

    def self.config_file # :nodoc:
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
