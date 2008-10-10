module Taza
  class Settings
    def self.browser
      env_settings = {}
      env_settings[:browser] = ENV['browser'].to_sym if ENV['browser']
      env_settings[:driver]  = ENV['driver'].to_sym if ENV['driver']
      self.defaults.merge(env_settings)
    end 

    def self.defaults
      YAML.load_file('spec/sandbox/config.yml')
    end

    def self.path
    end
  end
end
