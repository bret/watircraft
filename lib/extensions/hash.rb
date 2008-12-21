class Hash
  def convert_hash_keys_to_methods(fixture) # :nodoc:
    Taza::Entity.new(self,fixture)
  end
end
