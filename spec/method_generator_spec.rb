require 'spec/spec_helper'
require 'spec/spec_generator_helper'

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

  it "should be able to generate a method" do
    run_generator('spec', ['empty_shopping_cart'], generator_sources)
  end

end