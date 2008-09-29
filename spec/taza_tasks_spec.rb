require 'rubygems'
require 'need'
need { 'spec_helper' }

describe "Taza Tasks" do
  
  before :all do
    @file_name ="./lib/tasks/taza_tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  after :all do
    Rake.application = nil 
  end
  
  it "should create a rake task to run test unit tests marked with tags" do
    load @file_name 
    tasks.include?("test_tag").should be_true
  end
  
  it "should create a rake task to run specs marked with tags" do
    load @file_name 
    tasks.include?("spec_tag").should be_true
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end

describe "Site generation task" do
  
  before :all do
    @file_name ="./lib/tasks/taza_tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  it "should create a rake task to generate " do
    SiteGenerator.any_instance.expects(:file).with('site.rb.erb','lib/sites/foo.rb')
    SiteGenerator.any_instance.expects(:folder).with('lib/sites/foo')
    load @file_name 
    ENV['name'] = 'foo'
    @rake.invoke_task("generate:site")
  end
  
end