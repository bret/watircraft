module Taza
  class Browser
    class << self
      attr_accessor :drivers
    end
    self.drivers = {:watir => :create_watir, :firewatir => :create_firewatir}

    def self.create
      if(ENV['driver'].nil?)
        self.create_selenium(ENV['browser'])
      else
        self.send(self.drivers[ENV['driver'].to_sym])
      end
    end


    def self.create_watir
    end
  end
end
