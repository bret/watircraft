require 'spec/spec_helper'
require 'rubygems'
require 'taza'

describe Taza::Generators::Base do
  before :all do
    @template_file = 'rakefile.rb.erb'
  end
  
  it "should generate a rakefile without any erb tags" do
    generator = Taza::Generators::Base.new
    generator.render_template(@template_file).should_not match(/<%/)
    generator.render_template(@template_file).should_not match(/%>/)
  end
end
