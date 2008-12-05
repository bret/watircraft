module Taza
  class Browser
    def self.create_watir_ie
      require 'watir'
      Watir::IE.new
    end
  end
end
