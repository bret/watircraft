require 'spec/spec_helper'
require 'taza/fixture'
describe Taza::Fixture_methods do
  
  before :each do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
  end
  
  include Taza::Fixture_methods
  
  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).name.should eql('first')
  end
  
end