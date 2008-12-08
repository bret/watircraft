module Taza
  class Entity
    def initialize(hash)
      @hash = hash
      hash.keys.each do |key|
        self.class.class_eval <<-EOS
        def #{key}
          @hash['#{key}']
        end
        EOS
      end
    end
  end
end
