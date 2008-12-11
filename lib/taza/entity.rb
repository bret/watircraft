module Taza
  class Entity
   
    def initialize(hash,fixture)
      @hash = hash
      @fixture = fixture
      @hash.keys.each do |key|
        self.instance_eval do
          define_method(key) do
            if(@fixture.pluralized_fixture_exists?(key))
              @fixture.get_fixture_entity(key.pluralize_to_sym,@hash[key])
            else
              @hash[key]
            end
          end
        end
      end
    end
    
  end
end
