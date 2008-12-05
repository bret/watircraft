module Taza
  class Browser
    def self.create_watir_safari
      require 'safariwatir'
      Watir::Safari.new
    end
  end
end
