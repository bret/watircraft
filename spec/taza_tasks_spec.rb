require 'rubygems'
require 'spec/spec_helper'

describe "Taza Tasks" do
  
  before :all do
    @file_name ="./lib/taza/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  after :all do
    Rake.application = nil 
  end

  it "should create a rake task to generate a site" do
    load @file_name
    tasks.include?("generate:site").should be_true
  end

  it "should create a rake task to generate a page" do
    load @file_name
    tasks.include?("generate:page").should be_true
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end
