module Taza
  class Browser
    def self.watir_ie
      require 'watir'
      Watir::IE
    end
  end
end
