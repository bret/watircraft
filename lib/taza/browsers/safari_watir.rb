module Taza
  class Browser
    def self.watir_safari
      require 'safariwatir'
      Watir::Safari
    end
  end
end
