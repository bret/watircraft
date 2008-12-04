require 'spec/spec_helper'
require 'taza'

describe "Object" do
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
