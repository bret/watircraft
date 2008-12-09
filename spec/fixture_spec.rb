require 'spec/spec_helper'
require 'taza'

describe Taza::Fixture do
  
  it "should be able to load entries from fixtures" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    example = fixture.fixtures(:examples)['first_example']
    example.name.should eql("first")
    example.price.should eql(1)
  end

  it "should know if it has a fixture with a given name" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    fixture.has_fixture_file?(:examples).should be_true
    fixture.has_fixture_file?(:foo).should be_false
  end

  it "should use the spec folder as the base path" do
    Taza::Fixture.new.base_path.should eql('./spec')
  end
  
end