require 'spec/spec_helper'
require 'rubygems'
require 'fileutils'
require 'taza'

describe "Spec Generation" do
  include RubiGen::GeneratorTestHelper
  include Helpers::Generator
  include Helpers::Taza
  
  before :each do
    run_generator('taza', [APP_ROOT], generator_sources)
    @site_class = generate_site('Gap')
  end  

  it "should be able to generate a spec" do
    SpecGenerator.any_instance.stubs(:configured_site).returns(@site_class.to_s)
    run_generator('spec', ['add_book'], generator_sources)
  end

end