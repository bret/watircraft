require 'spec/spec_helper'
require 'rubygems'
require 'rake'

describe "Taza Tasks" do

  before :all do
    @file_name ="./lib/taza/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  after :all do
    Rake.application = nil
  end

  it "should create rake spec tasks for all sites" do
    Dir.expects(:glob).with('./spec/functional/*/').returns(['./spec/functional/foo/'])
    load @file_name
    tasks.include?("spec:functional:foo").should be_true
  end

  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end
