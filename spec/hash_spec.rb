require 'spec/spec_helper'

describe 'Hash Extensions' do
  it "should add methods for hash keys to some instance" do
    entity = {'apple' => 'pie'}.add_hash_keys_as_methods(nil)
    entity.should respond_to(:apple)
  end
  it "should not add the methods to a hash" do
    entity = {'apple' => 'pie'}.add_hash_keys_as_methods(nil)
    entity.should_not be_a_instance_of(Hash)
  end
end