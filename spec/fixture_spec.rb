require 'spec/spec_helper'
require 'taza'

describe Taza::Fixture do
  
  it "should be able to load entries from fixtures" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    example = fixture.get_fixture_entity('examples','first_example')
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

  it "should know if a pluralized fixture of that name exists" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    fixture.pluralized_fixture_exists?('example').should be_true
    fixture.pluralized_fixture_exists?('foo').should be_false
  end

  it "should use the spec folder as the base path" do
    Taza::Fixture.any_instance.stubs(:base_path).returns('./spec/sandbox')
    fixture = Taza::Fixture.new
    fixture.load_all
    hash = fixture.replace_one_to_one_relationship_keys_with_values({'user' => 'shatner'})
    hash['user'].name.should eql("William Shatner")
  end
  
end