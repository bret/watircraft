module Taza
  class Entity
    def initialize(hash,fixture)
      @hash = hash
      @fixture = fixture
      define_methods_for_hash_keys
    end
    
    def define_methods_for_hash_keys
      @hash.keys.each do |key|
        self.instance_eval <<-EOS
        def #{key}
          if(@fixture.pluralized_fixture_exists?('#{key}'))
            @fixture.get_fixture_entity('#{key}'.pluralize_to_sym,@hash['#{key}'])
          else
            @hash['#{key}']
          end
        end
        EOS
      end
    end
  end
end