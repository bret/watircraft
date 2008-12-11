module Taza
  class Entity
    def initialize(hash,fixture)
      @hash = hash
      @fixture = fixture
      define_methods_for_hash_keys
    end

    def define_methods_for_hash_keys
      @hash.keys.each do |key|
        create_method(key) do
          get_value_for_entry(key)
        end
      end
    end

    def get_value_for_entry(key)
      if @fixture.pluralized_fixture_exists?(key)
        @fixture.get_fixture_entity(key.pluralize_to_sym,@hash[key])
      else
        @hash[key]
      end
    end

    private
    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end

  end
end
