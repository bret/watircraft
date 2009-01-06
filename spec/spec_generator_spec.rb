require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe "Spec Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza
  
  before :each do
    generate_project
  end  

  after :each do
    bare_teardown   
  end

  it "should be able to generate a spec" do
    run_generator('spec', ['add penguin'], generator_sources)
  end

end