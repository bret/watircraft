require 'rubygems'
require 'rake'
require 'need'
require 'fileutils'
need { 'spec_helper' }
need { '../lib/generators/rake_generator' }
need { '../lib/tasks/tag_test_task' }

describe RakeGenerator do
  
  before :all do
    @file_name = "./spec/rakefile"
  end

  after :each do
    FileUtils.rm_f(@file_name)
  end

  it "should generate a rake file at a given path" do
    generator = RakeGenerator.new(@file_name)
    generator.generate
    File.exists?(@file_name).should be_true
  end

  it "should generate a rakefile without any erb tags" do
    generator = RakeGenerator.new(@file_name)
    generator.render_template.should_not match(/<%/)
    generator.render_template.should_not match(/%>/)
  end
end

describe "Generated Rake Tasks" do
  before :all do
    @file_name = "./spec/rakefile"
  end

  before :each do
    @rake = Rake::Application.new
    Rake.application = @rake
  end
  
  after :each do 
    Rake.application = nil
    FileUtils.rm_f(@file_name)
  end
  
  it "should create a rake task" do
    RakeGenerator.new(@file_name).generate
    load @file_name 
    lambda do
      @rake["test_tag"]
    end.should_not raise_error(RuntimeError)
 end

end
