require 'rubygems'
require 'rake'
require 'need'
need { 'spec_helper' }
need { '../lib/tasks/tag_test_task' }

describe FTW::Tasks::TagTestTask do
  it "should be able to create named tasks" do
    lambda do
      FTW::Tasks::TagTestTask.create("foo")
    end.should_not raise_error(ArgumentError)
  end

  it "should have a tags method" do
    lambda do
      task = FTW::Tasks::TagTestTask.create("foo")
      task.tags
    end.should_not raise_error(NoMethodError)
  end

  it "should take a block for initialize and then call the define method" do
    FTW::Tasks::TagTestTask.any_instance.expects(:define)

    FTW::Tasks::TagTestTask.create :some_name do
      "foo"
    end
  end
  
  it "should create a rake task" do

  end

end
