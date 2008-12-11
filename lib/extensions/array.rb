class Array
  def equivalent?(other_array)
    merged_array = self & other_array
    merged_array.size == self.size && merged_array.size == other_array.size
  end
end
