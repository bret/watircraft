require 'spec/spec_helper'
describe "Premade Rake Tasks" do
  before :all do
    @file_name ="./lib/taglob/rake/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  after :all do
    Rake.application = nil
  end
  
  it "should create a rake task to run test unit tests marked with tags" do
    load @file_name
    @rake.task_names_include?("test_tags").should be_true
  end
  it "should create a rake task to run test unit tests marked with tags" do
    load @file_name
    @rake.task_names_include?("spec_tags").should be_true
  end

end
