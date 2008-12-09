require 'spec/spec_helper'
require 'taza'

describe Taza::Fixture do
  
  before :each do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
  end
  
  it "should be able to load entries from fixtures" do
    fixture = Taza::Fixture.new
    fixture.load_all
    example = fixture.fixtures(:examples)['first_example']
    example.name.should eql("first")
    example.price.should eql(1)
  end

  it "should know if it has a fixture with a given name" do
    fixture = Taza::Fixture.new
    fixture.load_all
    fixture.has_fixture_file?(:examples).should be_true
    fixture.has_fixture_file?(:foo).should be_false
  end

  include Taza::Fixture_methods

  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).name.should eql('first')
  end
  
end