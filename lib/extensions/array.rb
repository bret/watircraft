class Array
  # Returns true if the two arrays elements are equal ignoring order
  # Example:
  #  [1,2].equivalent([2,1])    # => true
  #  [1,2,3].equivalent([2,1])  # => false
  def equivalent?(other_array)
    merged_array = self & other_array
    merged_array.size == self.size && merged_array.size == other_array.size
  end
end
