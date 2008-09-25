require 'rubygems'
require 'rake'
require 'need'
need { 'spec_helper' }
need { '../lib/tasks/tag_test_task' }

describe Taza::Tasks::TagTestTask do
  it "should be able to create named tasks" do
    lambda do
      Taza::Tasks::TagTestTask.create("foo")
    end.should_not raise_error(ArgumentError)
  end

  it "should have a tags method" do
    lambda do
      task = Taza::Tasks::TagTestTask.create("foo")
      task.tags
    end.should_not raise_error(NoMethodError)
  end

  it "should take a block for initialize and then call the define method" do
    Taza::Tasks::TagTestTask.any_instance.expects(:define)

    Taza::Tasks::TagTestTask.create :some_name do
      "foo"
    end
  end
  
end
