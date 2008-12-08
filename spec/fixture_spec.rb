require 'spec/spec_helper'
require 'rubygems'
require 'taza/fixture'

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
  
  it "should foo" do
    entry = Taza::Entity.new({'apple' => 'pie'})
    entry.apple.should eql('pie')
  end
end