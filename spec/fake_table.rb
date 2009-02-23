require 'ostruct'

# Replaces watir table in WatirCraft unit tests
class FakeTable
  attr_accessor :rows
  def initialize structure
    @rows = structure.map {|hash| FakeRow.new(hash)}
  end
end

class FakeRow
  def initialize hash
    @hash = hash
  end
  def element name
    FakeElement.new @hash, name
  end
end

class FakeElement
  def initialize hash, name
    @hash = hash
    @name = name
  end
  def display_value
    @hash[@name]
  end
  def exist?
    true
  end
  def set value
    @hash[@name] = value
  end
end
