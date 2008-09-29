require 'rubygems'
require 'need'
need { 'spec_helper' }
need { '../lib/generators/base_generator' }

describe BaseGenerator do
  before :all do
    @template_file = 'rakefile.rb.erb'
  end
  
  it "should generate a rakefile without any erb tags" do
    generator = BaseGenerator.new
    generator.render_template(@template_file).should_not match(/<%/)
    generator.render_template(@template_file).should_not match(/%>/)
  end
end