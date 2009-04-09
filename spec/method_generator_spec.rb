require 'spec/spec_helper'
require 'spec/spec_generator_helper'

describe "Spec Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza
  
  before :each do
    generate_project ["--site=frito"]
  end  

  after :each do
    bare_teardown   
  end

  it "should be able to generate a method" do
    run_generator('method', ['empty_shopping_cart'], generator_sources)
  end
  
  it "should work when when the provided name includes a space" do
    MethodGenerator.any_instance.stubs(:configured_site).returns('frito')
    generator = MethodGenerator.new(['check out'])
    generator.name.should == 'check_out'
  end
  
  it "should add a method to the site" do
    MethodGenerator.any_instance.stubs(:configured_site).returns('frito')
    run_generator('method', ['extra'], generator_sources)

    require File.join(PROJECT_FOLDER, 'lib/frito')
    Frito::Frito.any_instance.stubs(:base_path).returns(PROJECT_FOLDER)
    
    stub_settings
    stub_browser

    Frito::Frito.new.extra
  end
  
end
