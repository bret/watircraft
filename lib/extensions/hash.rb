class Hash
  def add_hash_keys_as_methods
    self.keys.each do |key|
      self.instance_eval <<-EOS
      def #{key}
        self['#{key}']
      end
      EOS
    end
    self
  end
end