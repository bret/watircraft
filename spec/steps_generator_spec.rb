require 'spec/spec_helper'
require 'spec/spec_generator_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe "Step Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza

  before :each do
    generate_project
  end

  after :each do
    bare_teardown   
  end

  it "should give you usage if you provide no arguments" do
    lambda { run_generator('steps', [], generator_sources) }.
      should raise_error(RubiGen::UsageError)
  end
  
   it "should be able to generate a steps file" do
    lambda{run_generator('steps', ['simple'], generator_sources)}.
      should_not raise_error
  end
end
