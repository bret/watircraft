module Taza
  class Settings
    def self.browser
      {:browser => ENV['browser'].to_sym,:driver => :watir}
    end 
  end
end