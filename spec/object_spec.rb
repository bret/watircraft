require 'spec/spec_helper'

describe "Object" do
  before :all do
    @orig_version = VERSION
    Object.send :remove_const, :VERSION
    Object.const_set :VERSION, "1.8.6"
    load 'lib/extensions/object.rb'
  end

  after :all do
    Object.send :remove_const, :VERSION
    Object.const_set :VERSION, @orig_version
  end

  it "should execute blocks with args in instance context" do
    str = "string"

    class << str
      def my_singleton_method(arg)
        arg
      end
    end

    block = Proc.new { |arg| my_singleton_method(arg) }

    str.instance_exec("foo",&block).should == "foo"
  end
end
