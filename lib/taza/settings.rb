module Taza
  class Settings
    def self.browser
      env_settings = {}
      env_settings[:browser] = ENV['browser'].to_sym if ENV['browser']
      env_settings[:driver]  = ENV['driver'].to_sym if ENV['driver']
      env_settings[:timeout] = ENV['timeout'] if ENV['timeout']
      env_settings[:server_ip] = ENV['server_ip'] if ENV['server_ip']
      env_settings[:server_port] = ENV['server_port'] if ENV['server_port']
      {:browser=>:firefox,:driver=>:selenium}.merge(config.merge(env_settings))
    end

    def self.config
      YAML.load_file(path)
    end

    def self.path
      'config/config.yml'
    end
  end
end
