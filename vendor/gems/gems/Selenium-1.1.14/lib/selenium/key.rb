module Selenium
  class Key
    def initialize(webpage, key)
      @webpage = webpage
      @key = key
    end

    def up
      @webpage.key_up(@key)
    end

    def down
      @webpage.key_down(@key)
    end
  end
end