require 'activesupport'

module Taza
  class Settings
    class << self
      # The config settings from the site.yml and config.yml files.  
      # ENV variables will override the settings.
      #
      # Example:
      #   Taza::Settings.config('google')
      def config(site_name=nil)
        keys = %w(browser driver timeout server_ip server_port visible speed attach leave_open)
        default_settings = {
          :browser => 'firefox', 
          :driver => 'watir', 
          :visible => true, 
          :speed => 'fast', 
          :attach => false, 
          :leave_open => false
        }
  
        env_settings = {}
        keys.each do |key|
          env_settings[key.to_sym] = ENV[key.upcase] if ENV[key.upcase]
        end
              
        # Because of the way #merge works, the settings at the bottom of the list
        # trump those at the top.
        settings = environment_settings.merge(
                     default_settings.merge(
                       config_file.merge(
                         env_settings)))
  
        settings[:browser] = settings[:browser].to_s
        settings[:driver] = settings[:driver].to_s
        settings[:speed] = settings[:speed].to_sym
        settings[:visible] = to_bool(settings[:visible])
        settings[:leave_open] = to_bool(settings[:leave_open])
        settings[:attach] = to_bool(settings[:attach])
        settings
      end
  
      # Returns a hash corresponding to the project config file.
      def config_file
        if File.exists?(config_file_path)
          hash = YAML.load_file(config_file_path)
        else
          hash = {}
        end
        convert_string_keys_to_symbols hash
      end
  
      def config_file_path # :nodoc:
        File.join(path, 'config', 'config.yml')
      end
      
      # Returns a hash for the currently specified test environment
      def environment_settings # :nodoc:
        file = File.join(path, environment_file)
        hash_of_hashes = YAML.load_file(file)
        unless hash_of_hashes.has_key? environment
          raise "Environment #{environment} not found in #{file}"
        end
        convert_string_keys_to_symbols hash_of_hashes[environment]
      end
      
      @@root = nil
  
      def path # :nodoc:
        @@root || APP_ROOT
      end
      
      def path= path
        @@root = path
      end
      
      def environment
        ENV['ENVIRONMENT'] || 'test'
      end
      
      def convert_string_keys_to_symbols hash
        returning Hash.new do |new_hash|
          hash.each_pair {|k, v| new_hash[k.to_sym] = v}
        end
      end
      
      def to_bool value
        case value
          when true, /true/i
            true
          else
            false
          end
      end
      
      private
      def environment_file
        'config/environments.yml'
      end
    end
  end
end
