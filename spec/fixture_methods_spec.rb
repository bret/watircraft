require 'spec/spec_helper'
require 'taza/fixture'
describe Taza::Fixtures do
  
  before :each do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
  end
  
  include Taza::Fixtures
  
  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).name.should eql('first')
  end
  
  it "should still raise method missing error" do
    lambda{zomgwtf(:first_example)}.should raise_error(NoMethodError)
  end
  
  #TODO: this test tests what is in entity's instance eval not happy with it being here
  it "should be able to look up a fixture entity off fixture_methods module" do
    examples(:first_example).user.name.should eql(users(:shatner).name)
  end
  
end