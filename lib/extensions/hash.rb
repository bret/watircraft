class Hash
  def convert_hash_keys_to_methods(fixture)
    Taza::Entity.new(self,fixture)
  end
end
