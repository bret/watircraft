require 'spec/spec_helper'
require 'rubygems'
require 'rake'
require 'taglob'

describe "Taza Tasks" do

  before :all do
    @file_name ="./lib/taza/tasks.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  before :each do
    Dir.stubs(:taglob).returns([])
  end

  after :all do
    Rake.application = nil
  end

  it "should create rake spec tasks for all sites" do
    Dir.stubs(:glob).with('./spec/functional/*/').returns(['./spec/functional/foo/'])
    Dir.stubs(:glob).with('./spec/functional/foo/*_spec.rb').returns([])
    load @file_name
    Taza::Rake::Tasks.new
    tasks.include?("spec:functional:foo").should be_true
  end

  it "should create rake spec tasks for all sites page specs" do
    Dir.expects(:glob).with('./spec/functional/*/').returns(['./spec/functional/foo/'])
    Dir.expects(:glob).with('./spec/functional/foo/*_spec.rb').returns(['./spec/functional/foo/page_spec.rb'])
    load @file_name
    Taza::Rake::Tasks.new
    tasks.include?("spec:functional:foo:page").should be_true
  end


  def tasks
    @rake.tasks.collect{|task| task.name }
  end

end
