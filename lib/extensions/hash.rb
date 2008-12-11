class Hash
  def add_hash_keys_as_methods(fixture)
    Taza::Entity.new(self,fixture)
  end
end
