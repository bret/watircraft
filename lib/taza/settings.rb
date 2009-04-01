require 'activesupport'

module Taza
  class Settings
    # The config settings from the site.yml and config.yml files.  
    # ENV variables will override the settings.
    #
    # Example:
    #   Taza::Settings.config('google')
    def self.config(site_name=nil)
      env_settings = {}
      keys = %w(browser driver timeout server_ip server_port visible speed)
      keys.each do |key|
        env_settings[key.to_sym] = ENV[key.upcase] if ENV[key.upcase]
      end
      
      default_settings = {:browser => 'firefox', :driver => 'watir', :visible => true, :speed => 'fast'}
      
      # Because of the way #merge works, the settings at the bottom of the list
      # trump those at the top.
      settings = environment_settings.merge(
                   default_settings.merge(
                     config_file.merge(
                       env_settings)))

      settings[:browser] = settings[:browser].to_s
      settings[:driver] = settings[:driver].to_s
      settings[:visible] = to_bool(settings[:visible])
      settings[:speed] = settings[:speed].to_sym
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
      file = File.join(path, environment_file)
      hash_of_hashes = YAML.load_file(file)
      unless hash_of_hashes.has_key? environment
        raise "Environment #{environment} not found in #{file}"
      end
      convert_string_keys_to_symbols hash_of_hashes[environment]
    end
    
    @@root = nil

    def self.path # :nodoc:
      @@root || APP_ROOT
    end
    
    def self.path= path
      @@root = path
    end
    
    def self.environment
      ENV['ENVIRONMENT'] || 'test'
    end
    
    def self.convert_string_keys_to_symbols hash
      returning Hash.new do |new_hash|
        hash.each_pair {|k, v| new_hash[k.to_sym] = v}
      end
    end
    
    def self.to_bool value
      case value
        when true, /true/i
          true
        else
          false
        end
    end
    
    private
    def self.environment_file
      'config/environments.yml'
    end
  end
end
