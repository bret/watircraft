require 'rubygems'
require 'need'
need { 'spec_helper' }
need { '../lib/generators/rake_generator' }

describe RakeGenerator do
  it "should generate a rake file at a given path" do
    generator = RakeGenerator.new("./rakefile")
    generator.stubs(:render_template).returns("foo")
    generator.expects(:write_file).with("foo")
    generator.generate
  end
end
