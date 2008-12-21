require 'spec/spec_helper'
require 'taza'

describe Taza::Entity do
  it "should add methods for hash string keys" do
    entity = Taza::Entity.new({'apple' => 'pie'},nil)
    entity.should respond_to(:apple)
  end
end