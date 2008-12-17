module Taza
  class Entity
    #Creates a entity, pass in a hash to be methodized and the fixture to look up other fixtures (not entirely happy with this abstraction)
    def initialize(hash,fixture)
      @hash = hash
      @fixture = fixture
      define_methods_for_hash_keys
    end
    
    #This method converts hash keys into methods onto the entity
    def define_methods_for_hash_keys
      @hash.keys.each do |key|
        create_method(key) do
          get_value_for_entry(key)
        end
      end
    end

    #This method will lookup another fixture if a pluralized fixture exists otherwise return the value in the hash
    def get_value_for_entry(key) # :nodoc:
      if @fixture.pluralized_fixture_exists?(key)
        @fixture.get_fixture_entity(key.pluralize_to_sym,@hash[key])
      else
        @hash[key]
      end
    end

    private
    def create_method(name, &block) # :nodoc:
      self.class.send(:define_method, name, &block)
    end

  end
end
