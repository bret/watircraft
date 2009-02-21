require 'ostruct'

# Replaces watir table in WatirCraft unit tests
class FakeTable
  attr_accessor :rows
  def initialize structure
    @rows = structure.map {|hash| FakeRow.new(OpenStruct.new(hash))}
  end
end

class FakeRow
  def initialize struct
    @struct = struct
  end
  def element name
    FakeElement.new @struct.send(name)
  end
end

class FakeElement
  def initialize string
    @value = string
  end
  def display_value
    @value
  end
end
