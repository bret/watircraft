require 'activesupport'

module Taza
  class Settings
    # The config settings from the site.yml and config.yml files.  
    # ENV variables will override the settings.
    #
    # Example:
    #   Taza::Settings.config('google')
    def self.config(site_name)
      env_settings = {}
      keys = %w(browser driver timeout server_ip server_port)
      keys.each do |key|
        env_settings[key.to_sym] = ENV[key.upcase] if ENV[key.upcase]
      end
      
      default_settings = {:browser => :firefox, :driver => :selenium}
      
      # Because of the way #merge works, the settings at the bottom of the list
      # trump those at the top.
      settings = environment_settings.merge(
                   default_settings.merge(
                     config_file.merge(
                       env_settings)))

      settings[:browser] = settings[:browser].to_sym
      settings[:driver] = settings[:driver].to_sym
      settings
    end

    # Returns a hash corresponding to the project config file.
    def self.config_file
      if File.exists?(config_file_path)
        hash = YAML.load_file(config_file_path)
      else
        hash = {}
      end
      self.convert_string_keys_to_symbols hash
    end

    def self.config_file_path # :nodoc:
      File.join(path, 'config', 'config.yml')
    end
    
    # Returns a hash for the currently specified test environment
    def self.environment_settings # :nodoc:
      array_of_hashes = YAML.load_file(File.join(path, environment_file))
      self.convert_string_keys_to_symbols array_of_hashes[ENV['TAZA_ENV']]
    end

    def self.path # :nodoc:
      '.'
    end
    
    def self.convert_string_keys_to_symbols hash
      returning Hash.new do |new_hash|
        hash.each_pair {|k, v| new_hash[k.to_sym] = v}
      end
    end
    
    private
    def self.environment_file
      'config/environments.yml'
    end
  end
end
