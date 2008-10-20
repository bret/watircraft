require 'activesupport'

module Taza
  class Settings
    def self.config(site_name)
      env_settings = {}
      env_settings[:browser] = ENV['browser'].to_sym if ENV['browser']
      env_settings[:driver]  = ENV['driver'].to_sym if ENV['driver']
      env_settings[:timeout] = ENV['timeout'] if ENV['timeout']
      env_settings[:server_ip] = ENV['server_ip'] if ENV['server_ip']
      env_settings[:server_port] = ENV['server_port'] if ENV['server_port']
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
      YAML.load_file(File.join(config_folder,"#{Inflector.underscore(site_name)}.yml"))[ENV['TAZA_ENV']]
    end

    def self.path # :nodoc:
      '.'
    end
  end
end
