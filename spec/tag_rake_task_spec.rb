require 'rubygems'
require 'rake'
require 'need'
need { 'spec_helper'}
need { '../lib/tasks/tag_test_task' }

describe 'rakefile' do
  before :each do
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  after :each do 
    Rake.application = nil
  end
  
  it "should create a rake task" do
    load File.join(File.dirname(__FILE__),'..','lib','generators','templates','rakefile.rb.erb')
    lambda do
      @rake["test_tag"]
    end.should_not raise_error(RuntimeError)
 end

  it "should set tags according to command line option" do
    FTW::Tasks::TagTestTask.any_instance.expects(:tags=).with("1,2,3")
    
    ENV["tags"] = "1,2,3"
    load File.join(File.dirname(__FILE__),'..','lib','generators','templates','rakefile.rb.erb')
    @rake["test_tag"].invoke
  end
end
