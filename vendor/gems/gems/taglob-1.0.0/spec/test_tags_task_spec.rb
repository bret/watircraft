require 'rubygems'
require 'spec/spec_helper'
require 'taglob/rake'

describe "Test/Spec Tags Task" do

  before :all do
    @file_name ="./lib/taglob/rake/test_task.rb"
    @rake = Rake::Application.new
    Rake.application = @rake
  end

  after :all do
    Rake.application = nil
  end

  it "should create a rake task to run test unit tests marked with tags" do
    task = Taglob::Rake::TestTagsTask.new :test_unit
    @rake.task_names_include?("test_unit").should be_true
  end

  it "should create a rake task to run spec tests marked with tags" do
    task = Taglob::Rake::SpecTagsTask.new :spec_tests
    @rake.task_names_include?("spec_tests").should be_true
  end

  it "should be able to run tags grouped as a OR" do
    task = Taglob::Rake::TestTagsTask.new :or_test do |t|
      t.pattern = 'spec/tagged_files/*.rb'
      t.tags = "bar|lulz"
    end
    tagged_files = task.test_files
    tagged_files.should_not include('spec/tagged_files/foo.rb')
    tagged_files.should include('spec/tagged_files/foo_bar_buttz.rb')
    tagged_files.should include('spec/tagged_files/epic_lulz.rb')
  end

  it "should be able to run tags grouped as a AND" do
    task = Taglob::Rake::TestTagsTask.new :and_test do |t|
      t.pattern = 'spec/tagged_files/*.rb'
      t.tags = "foo,bar"
    end
    tagged_files = task.test_files
    tagged_files.should_not include('spec/tagged_files/foo.rb')
    tagged_files.should include('spec/tagged_files/foo_bar_buttz.rb')
    tagged_files.should_not include('spec/tagged_files/epic_lulz.rb')
  end
end
