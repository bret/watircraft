class Hash
  def add_hash_keys_as_methods(fixture)
    @fixture = fixture
    self.keys.each do |key|
      self.instance_eval <<-EOS
      def #{key}
        if(@fixture.pluralized_fixture_exists?('#{key}'))
          @fixture.get_fixture_entity('#{key}',self['#{key}'])
        else
          self['#{key}']
        end
      end
      EOS
    end
    self
  end
end
