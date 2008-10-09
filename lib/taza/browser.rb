module Taza
  class Browser
    class << self
      attr_accessor :drivers
    end
    self.drivers = {:watir => :create_watir, :firewatir => :create_firewatir, :selenium => :create_selenium}

    def self.create
      if(ENV['driver'].nil?)
        self.create_selenium
      else
        self.send(self.drivers[ENV['driver'].to_sym])
      end
    end

    def self.create_watir
    end
    def self.create_selenium
      self.create_selenium_instance(ENV['browser'])
    end
  end
end
